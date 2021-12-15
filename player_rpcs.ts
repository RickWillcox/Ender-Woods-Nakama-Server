// Quests
function getPlayerQuests(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    var user_id = JSON.parse(payload).user_id;
    var user_quest_states : {} = _getCollection(nk, "individual_player_data", "user_quest_states", user_id)
    return JSON.stringify({success: true, result: user_quest_states})
}

function setPlayerQuests(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    logger.info(payload)
    var input = JSON.parse(payload)
    var user_id = input.user_id
    var version : string = _getCollectionVersion(nk, "individual_player_data", "user_quest_states", user_id)
    var quest_states = input.quest_states

    _setCollection(nk, "individual_player_data", "user_quest_states", version, quest_states, user_id)
    return JSON.stringify({success: true})
}

// Inventory
function getPlayerInventory(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    var user_id = JSON.parse(payload).user_id;
    var inventory : {} = _getCollection(nk, "individual_player_data", "inventory", user_id)
    return JSON.stringify({success: true, result: inventory})
}

function setPlayerInventory(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    logger.info(payload)
    var input = JSON.parse(payload)
    var user_id = input.user_id
    var version : string = _getCollectionVersion(nk, "individual_player_data", "inventory", user_id)
    var inventory = input.inventory

    _setCollection(nk, "individual_player_data", "inventory", version, inventory, user_id)
    return JSON.stringify({success: true})
}

// Stats
function setPlayerStats(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    logger.info(payload)
    var input = JSON.parse(payload)
    var user_id = input.user_id
    var version : string = _getCollectionVersion(nk, "individual_player_data", "player_stats", user_id)
    var player_stats = input.player_stats
    _setCollection(nk, "individual_player_data", "player_stats", version, player_stats, user_id)
    return JSON.stringify({success : true})
}

function getPlayerStats(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    var user_id = JSON.parse(payload).user_id;
    var player_stats : {} = _getCollection(nk, "individual_player_data", "player_stats", user_id)
    return JSON.stringify({success: true, result: player_stats})
}