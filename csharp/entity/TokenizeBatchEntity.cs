// TokenizeBatch entity client for the BluefinShieldconex SDK.

using Voxgig.Struct;

namespace BluefinShieldconexSdk.Entity;

public class TokenizeBatchEntity : BluefinShieldconexEntityBase
{
    public TokenizeBatchEntity(BluefinShieldconexSDK client, Dictionary<string, object?>? entopts = null)
        : base(client, entopts, "tokenize_batch")
    {
    }

    public override IEntity Make()
    {
        return new TokenizeBatchEntity(client, CloneOpts());
    }

    // (load not defined by this API - base class throws UnsupportedOp)

    // (list not defined by this API - base class throws UnsupportedOp)

    public override object? Create(Dictionary<string, object?>? reqdata,
        Dictionary<string, object?>? ctrl = null)
    {
        var ctx = utility.MakeContext(new Dictionary<string, object?>
        {
            ["opname"] = "create",
            ["ctrl"] = ctrl,
            ["match"] = match,
            ["data"] = data,
            ["reqdata"] = reqdata,
        }, entctx);
    
        return RunOp(ctx, () =>
        {
            if (ctx.Result != null)
            {
                if (ctx.Result.Resdata != null)
                {
                    data = Helpers.ToMapAny(
                        Voxgig.Struct.StructUtils.Clone(ctx.Result.Resdata))
                        ?? new Dictionary<string, object?>();
                }
            }
        });
    }

    // (update not defined by this API - base class throws UnsupportedOp)

    // (remove not defined by this API - base class throws UnsupportedOp)
}
