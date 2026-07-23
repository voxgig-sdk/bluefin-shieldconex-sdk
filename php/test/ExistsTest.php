<?php
declare(strict_types=1);

// BluefinShieldconex SDK exists test

require_once __DIR__ . '/../bluefinshieldconex_sdk.php';

use PHPUnit\Framework\TestCase;

class ExistsTest extends TestCase
{
    public function test_create_test_sdk(): void
    {
        $testsdk = BluefinShieldconexSDK::test(null, null);
        $this->assertNotNull($testsdk);
    }
}
