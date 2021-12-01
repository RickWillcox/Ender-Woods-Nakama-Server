

let afterAuthenticateCustom: nkruntime.AfterHookFunction<nkruntime.Session, nkruntime.AuthenticateCustomRequest> =
    function (ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, session: nkruntime.Session, inPayload: nkruntime.AuthenticateCustomRequest) {
    logger.info("Post auth exec hook")
    if (session.created && ctx.userId) {
        nk.accountUpdateId(ctx.userId, null, null, null, null, null, null, {gamedata: {experience: 0, current_health:-1}});
    }
};


let afterAuthenticateEmail: nkruntime.AfterHookFunction<nkruntime.Session, nkruntime.AuthenticateEmailRequest> =
    function (ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, session: nkruntime.Session, inPayload: nkruntime.AuthenticateEmailRequest) {
    logger.info("Post auth exec hook")
    if (session.created && ctx.userId) {
        nk.accountUpdateId(ctx.userId, null, null, null, null, null, null, {gamedata: {experience: 0, current_health:-1}});
    }
};