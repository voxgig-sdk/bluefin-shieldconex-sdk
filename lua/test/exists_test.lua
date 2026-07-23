-- BluefinShieldconex SDK exists test

local sdk = require("bluefin-shieldconex_sdk")

describe("BluefinShieldconexSDK", function()
  it("should create test SDK", function()
    local testsdk = sdk.test(nil, nil)
    assert.is_not_nil(testsdk)
  end)
end)
