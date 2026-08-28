package = "voxgig-sdk-bluefin-shieldconex"
version = "0.1.1-1"
source = {
  -- git+https (GitHub dropped git:// in 2022); pin the install to the release
  -- tag pushed by `make publish`, and point at the lua/ subdir of the monorepo.
  url = "git+https://github.com/voxgig-sdk/bluefin-shieldconex-sdk.git",
  tag = "lua/v0.1.1",
  dir = "bluefin-shieldconex-sdk/lua"
}
description = {
  summary = "Unofficial generated Lua SDK for the ShieldConex public API. Not affiliated with or endorsed by the upstream API provider.",
  homepage = "https://github.com/voxgig-sdk/bluefin-shieldconex-sdk",
  issues_url = "https://github.com/voxgig-sdk/bluefin-shieldconex-sdk/issues",
  license = "MIT",
  labels = { "voxgig", "sdk", "generated-sdk", "openapi", "api-client", "bluefin-shieldconex" }
}
dependencies = {
  "lua >= 5.3",
  "dkjson >= 2.5",
}
build = {
  type = "builtin",
  modules = {
    ["bluefin-shieldconex_sdk"] = "bluefin-shieldconex_sdk.lua",
    ["config"] = "config.lua",
    ["config_shared"] = "config_shared.lua",
    ["features"] = "features.lua",
    ["feature.base_feature"] = "feature/base_feature.lua",
    ["feature.audit_feature"] = "feature/audit_feature.lua",
    ["feature.clienttrack_feature"] = "feature/clienttrack_feature.lua",
    ["feature.idempotency_feature"] = "feature/idempotency_feature.lua",
    ["feature.log_feature"] = "feature/log_feature.lua",
    ["feature.metrics_feature"] = "feature/metrics_feature.lua",
    ["feature.paging_feature"] = "feature/paging_feature.lua",
    ["feature.ratelimit_feature"] = "feature/ratelimit_feature.lua",
    ["feature.retry_feature"] = "feature/retry_feature.lua",
    ["feature.telemetry_feature"] = "feature/telemetry_feature.lua",
    ["feature.test_feature"] = "feature/test_feature.lua",
    ["feature.timeout_feature"] = "feature/timeout_feature.lua",
  }
}
