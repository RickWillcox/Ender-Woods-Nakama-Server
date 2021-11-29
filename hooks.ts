

let afterAuthenticateCustom: nkruntime.AfterHookFunction<nkruntime.Session, nkruntime.AuthenticateCustomRequest> =
    function (ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, session: nkruntime.Session, inPayload: nkruntime.AuthenticateCustomRequest) {
    
    if (session.created && ctx.userId) {
        nk.accountUpdateId(ctx.userId, null, null, null, null, null, null, {"experience": 0, "current_health":-1});
    }
};
