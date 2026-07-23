<?php
declare(strict_types=1);

// BluefinShieldconex SDK utility registration

require_once __DIR__ . '/../core/UtilityType.php';
require_once __DIR__ . '/Clean.php';
require_once __DIR__ . '/Done.php';
require_once __DIR__ . '/MakeError.php';
require_once __DIR__ . '/FeatureAdd.php';
require_once __DIR__ . '/FeatureHook.php';
require_once __DIR__ . '/FeatureInit.php';
require_once __DIR__ . '/Fetcher.php';
require_once __DIR__ . '/MakeFetchDef.php';
require_once __DIR__ . '/MakeContext.php';
require_once __DIR__ . '/MakeOptions.php';
require_once __DIR__ . '/MakeRequest.php';
require_once __DIR__ . '/MakeResponse.php';
require_once __DIR__ . '/MakeResult.php';
require_once __DIR__ . '/MakePoint.php';
require_once __DIR__ . '/MakeSpec.php';
require_once __DIR__ . '/MakeUrl.php';
require_once __DIR__ . '/Param.php';
require_once __DIR__ . '/PrepareAuth.php';
require_once __DIR__ . '/PrepareBody.php';
require_once __DIR__ . '/PrepareHeaders.php';
require_once __DIR__ . '/PrepareMethod.php';
require_once __DIR__ . '/PrepareParams.php';
require_once __DIR__ . '/PreparePath.php';
require_once __DIR__ . '/PrepareQuery.php';
require_once __DIR__ . '/ResultBasic.php';
require_once __DIR__ . '/ResultBody.php';
require_once __DIR__ . '/ResultHeaders.php';
require_once __DIR__ . '/TransformRequest.php';
require_once __DIR__ . '/TransformResponse.php';

BluefinShieldconexUtility::setRegistrar(function (BluefinShieldconexUtility $u): void {
    $u->clean = [BluefinShieldconexClean::class, 'call'];
    $u->done = [BluefinShieldconexDone::class, 'call'];
    $u->make_error = [BluefinShieldconexMakeError::class, 'call'];
    $u->feature_add = [BluefinShieldconexFeatureAdd::class, 'call'];
    $u->feature_hook = [BluefinShieldconexFeatureHook::class, 'call'];
    $u->feature_init = [BluefinShieldconexFeatureInit::class, 'call'];
    $u->fetcher = [BluefinShieldconexFetcher::class, 'call'];
    $u->make_fetch_def = [BluefinShieldconexMakeFetchDef::class, 'call'];
    $u->make_context = [BluefinShieldconexMakeContext::class, 'call'];
    $u->make_options = [BluefinShieldconexMakeOptions::class, 'call'];
    $u->make_request = [BluefinShieldconexMakeRequest::class, 'call'];
    $u->make_response = [BluefinShieldconexMakeResponse::class, 'call'];
    $u->make_result = [BluefinShieldconexMakeResult::class, 'call'];
    $u->make_point = [BluefinShieldconexMakePoint::class, 'call'];
    $u->make_spec = [BluefinShieldconexMakeSpec::class, 'call'];
    $u->make_url = [BluefinShieldconexMakeUrl::class, 'call'];
    $u->param = [BluefinShieldconexParam::class, 'call'];
    $u->prepare_auth = [BluefinShieldconexPrepareAuth::class, 'call'];
    $u->prepare_body = [BluefinShieldconexPrepareBody::class, 'call'];
    $u->prepare_headers = [BluefinShieldconexPrepareHeaders::class, 'call'];
    $u->prepare_method = [BluefinShieldconexPrepareMethod::class, 'call'];
    $u->prepare_params = [BluefinShieldconexPrepareParams::class, 'call'];
    $u->prepare_path = [BluefinShieldconexPreparePath::class, 'call'];
    $u->prepare_query = [BluefinShieldconexPrepareQuery::class, 'call'];
    $u->result_basic = [BluefinShieldconexResultBasic::class, 'call'];
    $u->result_body = [BluefinShieldconexResultBody::class, 'call'];
    $u->result_headers = [BluefinShieldconexResultHeaders::class, 'call'];
    $u->transform_request = [BluefinShieldconexTransformRequest::class, 'call'];
    $u->transform_response = [BluefinShieldconexTransformResponse::class, 'call'];
});
