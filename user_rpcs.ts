// This functon just checks if the user is authenticated. It cannot be executed unless that is the case
function checkAuth(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    return JSON.stringify({success: true, user_id: ctx.userId, username: ctx.username})
}