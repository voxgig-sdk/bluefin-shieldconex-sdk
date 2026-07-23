// BluefinShieldconex SDK exists test.

using Xunit;

using BluefinShieldconexSdk;

namespace BluefinShieldconexSdk.Test;

public class ExistsTest
{
    [Fact]
    public void TestMode()
    {
        var testsdk = BluefinShieldconexSDK.TestSDK(null, null);
        Assert.NotNull(testsdk);
    }
}
