// Authentication
function checkAuth(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    var gamedata : {} = nk.accountGetId(ctx.userId).user.metadata.gamedata;
    return JSON.stringify({success: true, user_id: ctx.userId, username: ctx.username, gamedata: gamedata})
}

// Hello world - remove?
function rpcHealthCheck(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string): string {
    logger.info("health check done")
    return JSON.stringify({ success: true })
}
