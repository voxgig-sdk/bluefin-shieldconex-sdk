-- BluefinShieldconex SDK error

local BluefinShieldconexError = {}
BluefinShieldconexError.__index = BluefinShieldconexError


function BluefinShieldconexError.new(code, msg, ctx)
  local self = setmetatable({}, BluefinShieldconexError)
  self.is_sdk_error = true
  self.sdk = "BluefinShieldconex"
  self.code = code or ""
  self.msg = msg or ""
  self.ctx = ctx
  self.result = nil
  self.spec = nil
  return self
end


function BluefinShieldconexError:error()
  return self.msg
end


function BluefinShieldconexError:__tostring()
  return self.msg
end


return BluefinShieldconexError
