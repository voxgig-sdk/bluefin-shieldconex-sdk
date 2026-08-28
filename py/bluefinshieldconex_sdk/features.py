# BluefinShieldconex SDK feature factory

from bluefinshieldconex_sdk.feature.base_feature import BluefinShieldconexBaseFeature
from bluefinshieldconex_sdk.feature.audit_feature import BluefinShieldconexAuditFeature
from bluefinshieldconex_sdk.feature.clienttrack_feature import BluefinShieldconexClienttrackFeature
from bluefinshieldconex_sdk.feature.idempotency_feature import BluefinShieldconexIdempotencyFeature
from bluefinshieldconex_sdk.feature.log_feature import BluefinShieldconexLogFeature
from bluefinshieldconex_sdk.feature.metrics_feature import BluefinShieldconexMetricsFeature
from bluefinshieldconex_sdk.feature.paging_feature import BluefinShieldconexPagingFeature
from bluefinshieldconex_sdk.feature.ratelimit_feature import BluefinShieldconexRatelimitFeature
from bluefinshieldconex_sdk.feature.retry_feature import BluefinShieldconexRetryFeature
from bluefinshieldconex_sdk.feature.telemetry_feature import BluefinShieldconexTelemetryFeature
from bluefinshieldconex_sdk.feature.test_feature import BluefinShieldconexTestFeature
from bluefinshieldconex_sdk.feature.timeout_feature import BluefinShieldconexTimeoutFeature


_FEATURES = {
    "base": lambda: BluefinShieldconexBaseFeature(),
    "audit": lambda: BluefinShieldconexAuditFeature(),
    "clienttrack": lambda: BluefinShieldconexClienttrackFeature(),
    "idempotency": lambda: BluefinShieldconexIdempotencyFeature(),
    "log": lambda: BluefinShieldconexLogFeature(),
    "metrics": lambda: BluefinShieldconexMetricsFeature(),
    "paging": lambda: BluefinShieldconexPagingFeature(),
    "ratelimit": lambda: BluefinShieldconexRatelimitFeature(),
    "retry": lambda: BluefinShieldconexRetryFeature(),
    "telemetry": lambda: BluefinShieldconexTelemetryFeature(),
    "test": lambda: BluefinShieldconexTestFeature(),
    "timeout": lambda: BluefinShieldconexTimeoutFeature(),
}


def _make_feature(name):
    factory = _FEATURES.get(name)
    if factory is not None:
        return factory()
    return _FEATURES["base"]()


# True when this SDK was generated with the named feature class - the
# constructor's tolerance for extend-carried features reads this (an
# active name with no generated class must not become a BaseFeature
# stray when an extend instance carries it).
def _has_feature(name):
    return name in _FEATURES
