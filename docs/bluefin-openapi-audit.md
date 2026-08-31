# Bluefin SDK OpenAPI spec audit

Verification, on **2026-08-31**, that every `bluefin-*-sdk` repo in the
[`voxgig-sdk`](https://github.com/orgs/voxgig-sdk/repositories) org is generated
from the correct and current OpenAPI definition.

Ten SDK repos exist, and Bluefin publishes exactly ten API definitions across
the four projects on its developer portal — a clean one-to-one mapping, with no
SDK built from an unpublished spec and no published definition left without an
SDK.

## Result

All ten specs match what Bluefin publishes today. Eight are byte-identical to
the published document; two differ only in the `servers` block, where the
capture repaired a server URL that no generated client could call (see
[Deliberate local deltas](#deliberate-local-deltas)).

| SDK repo | spec in `.sdk/def/` | API title / version | ops | published as | last published | vs. published |
| --- | --- | --- | ---: | --- | --- | --- |
| `bluefin-shieldconex-sdk` | `shieldconex-openapi.json` | ShieldConex Api 1.0 | 12 | shieldconex :: `shieldconex-api.json` | 2026-04-13 | identical |
| `bluefin-shieldconex-mgmt-sdk` | `shieldconex-mgmt-openapi.json` | Shieldconex Management Api 1.0.0 | 21 | shieldconex :: `shieldconex-management-api.json` | 2026-04-13 | identical |
| `bluefin-network-token-sdk` | `network-token-openapi.json` | Network Token Bundle 1.0 | 4 | shieldconex :: `network-token-bundle.json` | 2026-04-13 | identical |
| `bluefin-decryptx-sdk` | `decryptx-openapi.json` | Decryptx APIs 1.3.0 | 5 | decryptx :: `decryptx-apis.json` | 2026-04-13 | servers normalised |
| `bluefin-decryptx-p2pe-sdk` | `decryptx-p2pe-openapi.json` | Decryptx External Api 1.0.0 | 52 | decryptx :: `decryptx-external-api.json` | 2026-04-13 | identical |
| `bluefin-payconex-sdk` | `payconex-openapi.json` | PayConex 4 4.0.1 | 44 | payconex :: `payconex-4.json` | 2026-04-13 | identical |
| `bluefin-tecs-ecr-sdk` | `tecs-ecr-openapi.json` | tecsclientrest 0.14.15 | 2 | tecs :: `TECS_API_REFERENCE_ECR_API_22-05-26.yaml` | 2026-06-24 | identical |
| `bluefin-tecs-merchant-portal-sdk` | `tecs-merchant-portal-openapi.json` | Merchant Portal Web Service Documentation 1.39.13 | 43 | tecs :: `merchant-portal-web-service-documentation.json` | 2026-04-13 | servers normalised |
| `bluefin-tecs-merchant-services-sdk` | `tecs-merchant-services-openapi.json` | Merchant Services 2.42.53 | 45 | tecs :: `merchant-services.json` | 2026-06-24 | identical |
| `bluefin-tecs-user-backoffice-sdk` | `tecs-user-backoffice-openapi.json` | User Back Office Web Service Documentation 0.56.3 | 25 | tecs :: `user-back-office-web-service-documentation.json` | 2026-04-13 | identical |

Every spec was seeded on 2026-07-23 and none has been edited since, so "matches
what is published today" is the whole freshness story: no upstream change has
been missed on any stable branch.

All ten also pass a structural check — no unresolved `$ref`, an `operationId`
on every operation, no duplicate operationIds, and a `responses` object on
every operation.

## Open issue: PayConex is pinned to the smallest of four published variants

The PayConex project publishes `payconex-4.json` on four documentation
branches, and they are **not** revisions of one document — they describe
materially different API surfaces:

| branch | stable? | file last published | paths | ops | schemas |
| --- | --- | --- | ---: | ---: | ---: |
| **1.2** (what the SDK uses) | yes | 2026-04-13 | 28 | 44 | 96 |
| 1.2.1 | no | 2026-04-13 | 66 | 84 | 176 |
| **4** | no | **2026-07-27** | 57 | 75 | 387 |
| 4.1 | no | 2026-04-13 | 53 | 71 | 311 |

Branch `4` holds the most recently published definition anywhere on the portal
— four days *after* our specs were captured. Against the SDK's spec it adds 42
operations and drops 11 (paths compared with path parameters normalised, so
renames like `{account}` → `{accountId}` are not counted as changes):

- **added**: `payments/*` (auth, credit, sale, force, store, device-\* variants,
  lookup by external transaction id) ×14, `poi/*` (terminal status, capture
  signature, list transactions) ×14, `devices/*` ×5, `level3-profile/*` ×5,
  webhook resend/test ×2, `GET /api/v4/device-profiles`, `GET /api/v4/pos-profiles`
- **dropped**: 3DS (`3DS/init-card-details`, browser-authenticate, status),
  Apple Pay (session, enrollment), and dynamic descriptors — all five of which
  the current SDK exposes

Branch `4` also carries usable absolute servers (`api-cert.payconex.net`,
`api.payconex.net`), where branch 1.2 gives only `https://api.payconex.net/`.

This is a product decision, not a defect: branch 1.2 is the one Bluefin marks
**stable**, and the SDK faithfully tracks it. But an SDK named `bluefin-payconex`
that cannot take a payment is a surprising surface. Worth confirming with
Bluefin which branch third-party integrators should build against; if it is `4`,
regenerating `bluefin-payconex-sdk` from that definition is the follow-up.

For comparison, the other three projects have no such ambiguity: ShieldConex's
branches 1.4, 1.4.5 (stable) and 1.5.0 all carry byte-identical definitions, and
decryptx and tecs publish a single branch each.

## Deliberate local deltas

Two captures rewrote the `servers` block because the published value is not a
usable base URL for a generated client. Both are intentional — a re-sync should
re-apply them, not "fix" them back:

| SDK | published | in `.sdk/def/` |
| --- | --- | --- |
| `bluefin-decryptx-sdk` | `[{"url": "/api"}]` | `https://secure-prod.decryptx.com/api` (Production), `https://secure-cert.decryptx.com/api` (Certification) |
| `bluefin-tecs-merchant-portal-sdk` | `[{"url": "//test.tecs.at"}]` | `https://test.tecs.at` (Test) |

The DecryptX hosts come from the spec's own non-standard `x-servers` extension,
where they are mislabelled — `secure-prod` is described as "Certification
server" and `secure-cert` as "Development server". The capture uses the sane
reading of the hostnames.

## Other observations

These are faithful copies of what Bluefin publishes, so they are upstream data
quality issues rather than capture errors — but they affect anyone using the
generated clients:

- **`bluefin-shieldconex-mgmt-sdk` ships a mock-server base URL.** Its single
  server is `https://portal-cert.shieldconex.com:4010/api/v1`; port 4010 is the
  Stoplight Prism mock default, which suggests the published spec was exported
  with a local mock's URL still in place. The real management API host needs
  confirming before anyone points a client at it.
- **Eight of ten specs default to a non-production host** (`secure-cert.*`,
  `portal-cert.*`, `test.tecs.at`). Only `bluefin-payconex-sdk`
  (`api.payconex.net`) and `bluefin-decryptx-p2pe-sdk`
  (`apis.p2pemanager.com`) default to production. Callers must override the base
  URL to reach production, which is a safe default but should be documented
  prominently in each SDK's README.
- **`bluefin-decryptx-p2pe-sdk` lists an `http://` server** alongside the
  `https://` one (`http://apis.p2pemanager.com/api/v1`), as published. Worth
  dropping on the next re-sync so no client can negotiate down to plaintext for
  a P2PE management API.

## How this was verified, and how to re-run it

Bluefin publishes on [developers.bluefin.com](https://developers.bluefin.com), a
ReadMe-hosted hub with four projects — `shieldconex`, `decryptx`, `payconex`,
`tecs`. The ReadMe v2 API needs a key, but each API reference page embeds the
complete OpenAPI document for the definition that owns the operation, so the
published spec can be recovered from the page itself and compared field by
field.

`.sdk/def/verify-spec.mjs` in each SDK repo does exactly that, for whichever SDK
it is run from:

```bash
node .sdk/def/verify-spec.mjs          # human-readable
node .sdk/def/verify-spec.mjs --json   # machine-readable
```

It exits `0` when the local spec matches the published definition (reporting any
locally normalised `servers`), `1` on drift, and `2` if the check could not run.
It also prints the stable branch and names any other branches, which is what
surfaced the PayConex situation above. The script currently lives only in
`bluefin-shieldconex-sdk`; copying it into the other nine repos is a
file-for-file copy, since the SDK name in `.sdk/model/sdk.aon` selects the right
entry from its `SOURCES` table.

Run it before each regeneration, or on a schedule — the freshness claim in this
document is only as good as its date.
