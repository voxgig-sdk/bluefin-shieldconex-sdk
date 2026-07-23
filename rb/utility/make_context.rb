# BluefinShieldconex SDK utility: make_context
require_relative '../core/context'
module BluefinShieldconexUtilities
  MakeContext = ->(ctxmap, basectx) {
    BluefinShieldconexContext.new(ctxmap, basectx)
  }
end
