function getItems(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    var items : {} = _getCollection(nk, "item_database", "items")
    if (Object.keys(items).length == 0)
    {
        return JSON.stringify({success : false, message: "Item database not initialized"})
    }
    return JSON.stringify({success: true, result: items})
}

function getRecipes(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    var items : {} = _getCollection(nk, "item_database", "recipes")
    if (Object.keys(items).length == 0)
    {
        return JSON.stringify({success : false, message: "Item database not initialized"})
    }
    return JSON.stringify({success: true, result: items})
}

function getModifiers(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    var items : {} = _getCollection(nk, "item_database", "modifiers")
    if (Object.keys(items).length == 0)
    {
        return JSON.stringify({success : false, message: "Item database not initialized"})
    }
    return JSON.stringify({success: true, result: items})
}