# BluefinShieldconex SDK utility registration
require_relative '../core/utility_type'
require_relative 'clean'
require_relative 'done'
require_relative 'make_error'
require_relative 'feature_add'
require_relative 'feature_hook'
require_relative 'feature_init'
require_relative 'fetcher'
require_relative 'make_fetch_def'
require_relative 'make_context'
require_relative 'make_options'
require_relative 'make_request'
require_relative 'make_response'
require_relative 'make_result'
require_relative 'make_point'
require_relative 'make_spec'
require_relative 'make_url'
require_relative 'param'
require_relative 'prepare_auth'
require_relative 'prepare_body'
require_relative 'prepare_headers'
require_relative 'prepare_method'
require_relative 'prepare_params'
require_relative 'prepare_path'
require_relative 'prepare_query'
require_relative 'result_basic'
require_relative 'result_body'
require_relative 'result_headers'
require_relative 'transform_request'
require_relative 'transform_response'

BluefinShieldconexUtility.registrar = ->(u) {
  u.clean = BluefinShieldconexUtilities::Clean
  u.done = BluefinShieldconexUtilities::Done
  u.make_error = BluefinShieldconexUtilities::MakeError
  u.feature_add = BluefinShieldconexUtilities::FeatureAdd
  u.feature_hook = BluefinShieldconexUtilities::FeatureHook
  u.feature_init = BluefinShieldconexUtilities::FeatureInit
  u.fetcher = BluefinShieldconexUtilities::Fetcher
  u.make_fetch_def = BluefinShieldconexUtilities::MakeFetchDef
  u.make_context = BluefinShieldconexUtilities::MakeContext
  u.make_options = BluefinShieldconexUtilities::MakeOptions
  u.make_request = BluefinShieldconexUtilities::MakeRequest
  u.make_response = BluefinShieldconexUtilities::MakeResponse
  u.make_result = BluefinShieldconexUtilities::MakeResult
  u.make_point = BluefinShieldconexUtilities::MakePoint
  u.make_spec = BluefinShieldconexUtilities::MakeSpec
  u.make_url = BluefinShieldconexUtilities::MakeUrl
  u.param = BluefinShieldconexUtilities::Param
  u.prepare_auth = BluefinShieldconexUtilities::PrepareAuth
  u.prepare_body = BluefinShieldconexUtilities::PrepareBody
  u.prepare_headers = BluefinShieldconexUtilities::PrepareHeaders
  u.prepare_method = BluefinShieldconexUtilities::PrepareMethod
  u.prepare_params = BluefinShieldconexUtilities::PrepareParams
  u.prepare_path = BluefinShieldconexUtilities::PreparePath
  u.prepare_query = BluefinShieldconexUtilities::PrepareQuery
  u.result_basic = BluefinShieldconexUtilities::ResultBasic
  u.result_body = BluefinShieldconexUtilities::ResultBody
  u.result_headers = BluefinShieldconexUtilities::ResultHeaders
  u.transform_request = BluefinShieldconexUtilities::TransformRequest
  u.transform_response = BluefinShieldconexUtilities::TransformResponse
}
