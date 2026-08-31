# Spec provenance

`shieldconex-openapi.json` is a capture of the OpenAPI definition Bluefin
publishes for the ShieldConex tokenization API.

| | |
| --- | --- |
| Source | [developers.bluefin.com/shieldconex](https://developers.bluefin.com/shieldconex) (ReadMe-hosted) |
| Published as | `shieldconex-api.json`, branch 1.4.5 (stable) |
| Upstream last published | 2026-04-13 |
| Captured into this repo | 2026-07-23 |
| Last verified against upstream | 2026-08-31 — byte-identical, 12 operations |

Branches 1.4 and 1.5.0 carry byte-identical definitions, so this SDK is current
whichever branch Bluefin promotes next.

No local edits: this file is exactly what the portal serves. If a future
re-sync has to change the spec by hand — a relative `servers` URL, say, which
two sibling SDKs did need — record the change here so the next re-sync
re-applies it instead of reverting it.

## Re-checking

```bash
node .sdk/def/verify-spec.mjs          # human-readable
node .sdk/def/verify-spec.mjs --json   # machine-readable
```

Exits `0` when the local spec still matches the published definition, `1` on
drift, `2` if the check could not run (network, or the portal's markup moved).
Run it before regenerating.

The same script works in every `bluefin-*-sdk` repo — the SDK name in
`.sdk/model/sdk.aon` selects its entry from the script's `SOURCES` table.

See [`docs/bluefin-openapi-audit.md`](../../docs/bluefin-openapi-audit.md) for
the same check applied across all ten Bluefin SDKs.
