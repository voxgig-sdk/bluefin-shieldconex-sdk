# BluefinShieldconex SDK utility: prepare_body
require_relative 'media'
module BluefinShieldconexUtilities
  PrepareBody = ->(ctx) {
    return nil unless ctx.op.input == "data"
    return BluefinShieldconexUtilities.raw_body(ctx.reqdata) if BluefinShieldconexUtilities.raw_request?(ctx.point)
    ctx.utility.transform_request.call(ctx)
  }
end
