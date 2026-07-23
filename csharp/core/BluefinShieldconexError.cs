// BluefinShieldconexError - the SDK error type. Carries the pipeline error code,
// the originating context and cleaned result/spec snapshots.

namespace BluefinShieldconexSdk;

public class BluefinShieldconexError : Exception
{
    public bool IsBluefinShieldconexError = true;
    public string Sdk = "BluefinShieldconex";
    public string Code;
    public Context? Ctx;
    public object? ResultVal;
    public object? SpecVal;

    public BluefinShieldconexError(string code, string msg, Context? ctx)
        : base(msg)
    {
        Code = code;
        Ctx = ctx;
    }
}
