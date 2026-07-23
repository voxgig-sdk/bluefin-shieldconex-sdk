<?php
declare(strict_types=1);

// BluefinShieldconex SDK utility: make_context

require_once __DIR__ . '/../core/Context.php';

class BluefinShieldconexMakeContext
{
    public static function call(array $ctxmap, ?BluefinShieldconexContext $basectx): BluefinShieldconexContext
    {
        return new BluefinShieldconexContext($ctxmap, $basectx);
    }
}
