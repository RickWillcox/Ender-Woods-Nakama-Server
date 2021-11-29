// This functon just checks if the user is authenticated. It cannot be executed unless that is the case
function checkAuth(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    var gamedata : {} = nk.accountGetId(ctx.userId).user.metadata.gamedata;
    return JSON.stringify({success: true, user_id: ctx.userId, username: ctx.username, gamedata: gamedata})
}

function updateGameData(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    logger.info(payload)
    var metdata : {[key : string] : any} = nk.accountGetId(ctx.userId).user.metadata
    var input : {[key : string] : any} = JSON.parse(payload)
    var user_id = input.user_id
    if (input.experience)
    {
        metdata.gamedata.experience = input.experience
    }

    if (input.current_health)
    {
        metdata.gamedata.current_health = input.current_health
    }
    nk.accountUpdateId(user_id, null, null, null, null, null, null, metdata)
    return JSON.stringify({success : true})
}

function getGameData(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    logger.info(payload)
    var metdata : {[key : string] : any} = nk.accountGetId(ctx.userId).user.metadata
    return JSON.stringify(metdata.gamedata)
}
