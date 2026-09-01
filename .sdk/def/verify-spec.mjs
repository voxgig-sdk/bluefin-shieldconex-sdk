#!/usr/bin/env node
/**
 * Verify the OpenAPI spec in .sdk/def against what Bluefin publishes today.
 *
 * The specs in these SDKs are captured from the Bluefin developer portal
 * (developers.bluefin.com), a ReadMe-hosted hub. Each API reference page
 * embeds the complete OpenAPI document for the definition that owns the
 * operation, so the published spec can be recovered without an API key.
 *
 * Usage:  node .sdk/def/verify-spec.mjs [--json]
 *
 * Exit codes:
 *   0  local spec matches the published definition (server block may be
 *      normalised locally — reported, not an error)
 *   1  the API surface has drifted, or a newer branch carries a different spec
 *   2  the check could not run (network, unknown SDK, portal markup changed)
 *
 * The same script works in every bluefin-*-sdk repo: the SDK name in
 * .sdk/model/sdk.aon selects its entry in SOURCES below.
 */

import { readFileSync, readdirSync } from 'node:fs'
import { dirname, join } from 'node:path'
import { fileURLToPath } from 'node:url'

const DEF_DIR = dirname(fileURLToPath(import.meta.url))
const SDK_DIR = dirname(DEF_DIR)
const HUB = 'https://developers.bluefin.com'

// SDK name (from model/sdk.aon) -> where its definition is published.
// `slug` is any reference page belonging to that definition; `title` guards
// against the slug drifting onto a different definition.
const SOURCES = {
  'bluefin-shieldconex': {
    project: 'shieldconex', slug: 'tokenize',
    file: 'shieldconex-api.json', title: 'ShieldConex Api' },
  'bluefin-shieldconex-mgmt': {
    project: 'shieldconex', slug: 'create-user',
    file: 'shieldconex-management-api.json', title: 'Shieldconex Management Api' },
  'bluefin-network-token': {
    project: 'shieldconex', slug: 'create-network-token-bundle',
    file: 'network-token-bundle.json', title: 'Network Token Bundle' },
  'bluefin-decryptx': {
    project: 'decryptx', slug: 'decrypt',
    file: 'decryptx-apis.json', title: 'Decryptx APIs' },
  'bluefin-decryptx-p2pe': {
    project: 'decryptx', slug: 'create-device',
    file: 'decryptx-external-api.json', title: 'Decryptx External Api' },
  'bluefin-payconex': {
    project: 'payconex', slug: 'createapikey',
    file: 'payconex-4.json', title: 'PayConex 4' },
  'bluefin-tecs-ecr': {
    project: 'tecs', slug: 'getecrversion',
    file: 'TECS_API_REFERENCE_ECR_API_22-05-26.yaml', title: 'tecsclientrest' },
  'bluefin-tecs-merchant-portal': {
    project: 'tecs', slug: 'registernewmerchantusingpost',
    file: 'merchant-portal-web-service-documentation.json',
    title: 'Merchant Portal Web Service Documentation' },
  'bluefin-tecs-merchant-services': {
    project: 'tecs', slug: 'paymenttransaction',
    file: 'merchant-services.json', title: 'Merchant Services' },
  'bluefin-tecs-user-backoffice': {
    project: 'tecs', slug: 'registeruser',
    file: 'user-back-office-web-service-documentation.json',
    title: 'User Back Office Web Service Documentation' },
}

// Keys the hub adds or the capture deliberately rewrites. `servers` is
// normalised on capture because ReadMe publishes relative or
// protocol-relative server URLs that no generated client can call.
const IGNORE_TOP = ['x-readme']
const NORMALISED_TOP = ['servers']

const fail = (msg) => { console.error(`verify-spec: ${msg}`); process.exit(2) }

// --- local side ------------------------------------------------------------

function localSpec() {
  const aon = readFileSync(join(SDK_DIR, 'model', 'sdk.aon'), 'utf8')
  const name = aon.match(/^\s*name:\s*'([^']+)'/m)?.[1]
  const def = aon.match(/^\s*def:\s*'([^']+)'/m)?.[1]
  if (!name) fail('no `name:` in .sdk/model/sdk.aon')
  const file = def && readdirSync(DEF_DIR).includes(def)
    ? def
    : readdirSync(DEF_DIR).find((f) => /\.(json|ya?ml)$/.test(f))
  if (!file) fail('no spec file in .sdk/def')
  return { name, file, spec: JSON.parse(readFileSync(join(DEF_DIR, file), 'utf8')) }
}

// --- portal side -----------------------------------------------------------

async function get(url) {
  const res = await fetch(url, { redirect: 'follow' })
  if (!res.ok) fail(`GET ${url} -> ${res.status}`)
  return res.text()
}

// Pull the balanced JSON value that follows `"key":<open>` in a blob of HTML.
function* jsonValues(html, key, open = '{') {
  const close = open === '{' ? '}' : ']'
  const needle = `"${key}":${open}`
  for (let i = html.indexOf(needle); i >= 0; i = html.indexOf(needle, i + 1)) {
    const start = html.indexOf(open, i)
    let depth = 0, inStr = false, esc = false
    for (let j = start; j < html.length; j++) {
      const c = html[j]
      if (esc) { esc = false; continue }
      if (c === '\\') { esc = true; continue }
      if (c === '"') { inStr = !inStr; continue }
      if (inStr) continue
      if (c === open) depth++
      else if (c === close && --depth === 0) { yield html.slice(start, j + 1); break }
    }
  }
}

function extract(html, key, open, pick) {
  // The hub embeds this state as raw JSON in a script tag on some pages and
  // as escaped JSON in an attribute on others; try both readings.
  for (const text of [html, html.replaceAll('\\"', '"')]) {
    let best = null, bestLen = 0
    for (const raw of jsonValues(text, key, open)) {
      let value
      try { value = JSON.parse(raw) } catch { continue }
      if (!pick(value)) continue
      if (raw.length > bestLen) { best = value; bestLen = raw.length }
    }
    if (best !== null) return best
  }
  return null
}

const isOas = (v) => v && typeof v === 'object' && v.paths && v.info && (v.openapi || v.swagger)

// --- comparison ------------------------------------------------------------

const stable = (o) => JSON.stringify(sortDeep(o))
function sortDeep(o) {
  if (Array.isArray(o)) return o.map(sortDeep)
  if (o && typeof o === 'object') {
    return Object.fromEntries(Object.keys(o).sort().map((k) => [k, sortDeep(o[k])]))
  }
  return o
}

function operations(spec) {
  const verbs = new Set(['get', 'put', 'post', 'delete', 'patch', 'head', 'options', 'trace'])
  const out = new Set()
  for (const [p, item] of Object.entries(spec.paths ?? {})) {
    for (const m of Object.keys(item)) {
      if (verbs.has(m.toLowerCase())) out.add(`${m.toUpperCase()} ${p}`)
    }
  }
  return out
}

const strip = (spec, keys) => Object.fromEntries(
  Object.entries(spec).filter(([k]) => !keys.includes(k)))

// --- main ------------------------------------------------------------------

const asJson = process.argv.includes('--json')
const { name, file, spec: local } = localSpec()
const source = SOURCES[name]
if (!source) fail(`unknown SDK '${name}' — add it to SOURCES in this script`)

const refHtml = await get(`${HUB}/${source.project}/reference/${source.slug}`)
const published = extract(refHtml, 'schema', '{', isOas)
if (!published) {
  fail(`no OpenAPI document on ${HUB}/${source.project}/reference/${source.slug} `
     + '— the reference slug or the portal markup changed')
}
if (published.info?.title !== source.title) {
  fail(`reference page now serves '${published.info?.title}', expected '${source.title}'`)
}

const listHtml = await get(`${HUB}/${source.project}/reference`)
const defs = extract(listHtml, 'apiDefinitions', '[', (v) => Array.isArray(v) && v[0]?.filename) ?? []
const entry = defs.find((d) => d.filename === source.file)
const versions = extract(listHtml, 'versions', '[', (v) => Array.isArray(v) && v[0]?.version) ?? []
const stableBranch = versions.find((v) => v.is_stable)?.version ?? null
const otherBranches = versions.filter((v) => !v.is_stable).map((v) => v.version)

const localOps = operations(local)
const pubOps = operations(published)
const missing = [...pubOps].filter((o) => !localOps.has(o)).sort()
const extra = [...localOps].filter((o) => !pubOps.has(o)).sort()

const bare = (s) => strip(s, [...IGNORE_TOP, ...NORMALISED_TOP])
const identical = stable(bare(local)) === stable(bare(published))
const serversDiffer = stable(local.servers ?? null) !== stable(published.servers ?? null)

const result = {
  sdk: name,
  spec: file,
  source: `${HUB}/${source.project} :: ${source.file}`,
  publishedUpdatedAt: entry?.updated_at ?? null,
  stableBranch,
  otherBranches,
  inSync: identical,
  serversNormalisedLocally: serversDiffer,
  localServers: local.servers ?? null,
  publishedServers: published.servers ?? null,
  missingLocally: missing,
  extraLocally: extra,
}

if (asJson) {
  console.log(JSON.stringify(result, null, 2))
} else {
  console.log(`SDK        ${name}`)
  console.log(`spec       .sdk/def/${file}  (${localOps.size} operations)`)
  console.log(`published  ${source.file} on ${HUB}/${source.project}`)
  console.log(`           branch ${stableBranch} (stable), last published ${result.publishedUpdatedAt ?? 'unknown'}`)
  if (otherBranches.length) {
    console.log(`           other branches: ${otherBranches.join(', ')} — not checked here,`)
    console.log('           a non-stable branch may carry a different definition')
  }
  console.log('')
  if (identical) console.log('OK         local spec matches the published definition')
  else console.log('DRIFT      local spec differs from the published definition')
  if (serversDiffer) {
    console.log(`note       servers normalised locally: ${JSON.stringify(result.localServers)}`)
    console.log(`           published: ${JSON.stringify(result.publishedServers)}`)
  }
  for (const o of missing) console.log(`missing    ${o}`)
  for (const o of extra) console.log(`extra      ${o}`)
}

process.exit(identical ? 0 : 1)
