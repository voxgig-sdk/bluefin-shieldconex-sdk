<?php
declare(strict_types=1);

// BluefinShieldconex SDK feature factory

require_once __DIR__ . '/feature/BaseFeature.php';
require_once __DIR__ . '/feature/TestFeature.php';


class BluefinShieldconexFeatures
{
    public static function make_feature(string $name)
    {
        switch ($name) {
            case "base":
                return new BluefinShieldconexBaseFeature();
            case "test":
                return new BluefinShieldconexTestFeature();
            default:
                return new BluefinShieldconexBaseFeature();
        }
    }
}
