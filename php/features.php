<?php
declare(strict_types=1);

// BluefinShieldconex SDK feature factory

require_once __DIR__ . '/feature/BaseFeature.php';
require_once __DIR__ . '/feature/AuditFeature.php';
require_once __DIR__ . '/feature/ClienttrackFeature.php';
require_once __DIR__ . '/feature/IdempotencyFeature.php';
require_once __DIR__ . '/feature/LogFeature.php';
require_once __DIR__ . '/feature/MetricsFeature.php';
require_once __DIR__ . '/feature/PagingFeature.php';
require_once __DIR__ . '/feature/RatelimitFeature.php';
require_once __DIR__ . '/feature/RetryFeature.php';
require_once __DIR__ . '/feature/TelemetryFeature.php';
require_once __DIR__ . '/feature/TestFeature.php';
require_once __DIR__ . '/feature/TimeoutFeature.php';


class BluefinShieldconexFeatures
{
    public static function make_feature(string $name)
    {
        switch ($name) {
            case "base":
                return new BluefinShieldconexBaseFeature();
            case "audit":
                return new BluefinShieldconexAuditFeature();
            case "clienttrack":
                return new BluefinShieldconexClienttrackFeature();
            case "idempotency":
                return new BluefinShieldconexIdempotencyFeature();
            case "log":
                return new BluefinShieldconexLogFeature();
            case "metrics":
                return new BluefinShieldconexMetricsFeature();
            case "paging":
                return new BluefinShieldconexPagingFeature();
            case "ratelimit":
                return new BluefinShieldconexRatelimitFeature();
            case "retry":
                return new BluefinShieldconexRetryFeature();
            case "telemetry":
                return new BluefinShieldconexTelemetryFeature();
            case "test":
                return new BluefinShieldconexTestFeature();
            case "timeout":
                return new BluefinShieldconexTimeoutFeature();
            default:
                return new BluefinShieldconexBaseFeature();
        }
    }

    /**
     * Does a generated feature class back this name? False for a name only
     * an options extend instance can supply (the station adopt path) - the
     * constructor uses this to skip make_feature for such names instead of
     * adding a stray BaseFeature.
     */
    public static function has_feature(string $name): bool
    {
        switch ($name) {
            case "base":
            case "audit":
            case "clienttrack":
            case "idempotency":
            case "log":
            case "metrics":
            case "paging":
            case "ratelimit":
            case "retry":
            case "telemetry":
            case "test":
            case "timeout":
                return true;
            default:
                return false;
        }
    }
}
