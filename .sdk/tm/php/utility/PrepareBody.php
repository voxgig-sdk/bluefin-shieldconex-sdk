<?php
declare(strict_types=1);

// BluefinShieldconex SDK utility: prepare_body

class BluefinShieldconexPrepareBody
{
    public static function call(BluefinShieldconexContext $ctx): mixed
    {
        if ($ctx->op->input === 'data') {
            return ($ctx->utility->transform_request)($ctx);
        }
        return null;
    }
}
