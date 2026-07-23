<?php
declare(strict_types=1);

// BluefinShieldconex SDK base feature

class BluefinShieldconexBaseFeature
{
    public string $version;
    public string $name;
    public bool $active;

    // Positions this feature when added via the client `extend` option:
    // "__before__" / "__after__" / "__replace__" name an already-added
    // feature (mirrors the ts feature `_options`). Declared so setting it
    // on an extension instance avoids the dynamic-property deprecation.
    public ?array $_options = null;

    public function __construct()
    {
        $this->version = '0.0.1';
        $this->name = 'base';
        $this->active = true;
    }

    public function get_version(): string { return $this->version; }
    public function get_name(): string { return $this->name; }
    public function get_active(): bool { return $this->active; }

    public function init(BluefinShieldconexContext $ctx, array $options): void {}
    public function PostConstruct(BluefinShieldconexContext $ctx): void {}
    public function PostConstructEntity(BluefinShieldconexContext $ctx): void {}
    public function SetData(BluefinShieldconexContext $ctx): void {}
    public function GetData(BluefinShieldconexContext $ctx): void {}
    public function GetMatch(BluefinShieldconexContext $ctx): void {}
    public function SetMatch(BluefinShieldconexContext $ctx): void {}
    public function PrePoint(BluefinShieldconexContext $ctx): void {}
    public function PreSpec(BluefinShieldconexContext $ctx): void {}
    public function PreRequest(BluefinShieldconexContext $ctx): void {}
    public function PreResponse(BluefinShieldconexContext $ctx): void {}
    public function PreResult(BluefinShieldconexContext $ctx): void {}
    public function PreDone(BluefinShieldconexContext $ctx): void {}
    public function PreUnexpected(BluefinShieldconexContext $ctx): void {}
}
