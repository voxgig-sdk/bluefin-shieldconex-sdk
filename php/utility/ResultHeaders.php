<?php
declare(strict_types=1);

// BluefinShieldconex SDK utility: result_headers

class BluefinShieldconexResultHeaders
{
    public static function call(BluefinShieldconexContext $ctx): ?BluefinShieldconexResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result) {
            if ($response && is_array($response->headers)) {
                $result->headers = $response->headers;
            } else {
                $result->headers = [];
            }
        }
        return $result;
    }
}
