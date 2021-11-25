function getInventory(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    var user_id = JSON.parse(payload).user_id;
    var inventory : {} = _getCollection(nk, "item_database", "inventory", user_id)
    return JSON.stringify({success: true, result: inventory})
}

function setInventory(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    logger.info(payload)
    var input = JSON.parse(payload)
    var user_id = input.user_id
    var version : string = _getCollectionVersion(nk, "item_database", "inventory", user_id)
    var inventory = input.inventory

    _setCollection(nk, "item_database", "inventory", version, inventory, user_id)
    return JSON.stringify({success: true})
}