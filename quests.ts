function getQuests(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    var quests : {} = _getCollection(nk, "quest_database", "quests")
    if (Object.keys(quests).length == 0)
    {
        return JSON.stringify({success : false, message: "Quest database not initialized"})
    }
    return JSON.stringify({success: true, result: quests})
}

function getUserQuestStates(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    var user_id = JSON.parse(payload).user_id;
    var user_quest_states : {} = _getCollection(nk, "quest_database", "user_quest_state", user_id)
    return JSON.stringify({success: true, result: user_quest_states})
}

function setUserQuestStates(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    logger.info(payload)
    var input = JSON.parse(payload)
    var user_id = input.user_id
    var version : string = _getCollectionVersion(nk, "quest_database", "user_quest_state", user_id)
    var quest_states = input.quest_states

    _setCollection(nk, "item_database", "inventory", version, quest_states, user_id)
    return JSON.stringify({success: true})
}
