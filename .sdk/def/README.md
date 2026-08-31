# API Definition
 
API definition (OpenAPI etc) files live here.

- `shieldconex-openapi.json` — the spec this SDK is generated from. It is
  selected by `def:` in [`../model/sdk.aon`](../model/sdk.aon).
- [`PROVENANCE.md`](./PROVENANCE.md) — where that spec came from, when it was
  captured, and when it was last verified against upstream.
- `verify-spec.mjs` — re-checks the spec against what Bluefin publishes today:
  `node .sdk/def/verify-spec.mjs`.
