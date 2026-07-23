<?php
declare(strict_types=1);

// BluefinShieldconex SDK utility: result_body

class BluefinShieldconexResultBody
{
    public static function call(BluefinShieldconexContext $ctx): ?BluefinShieldconexResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result && $response && $response->json_func && $response->body) {
            $result->body = ($response->json_func)();
        }
        return $result;
    }
}
