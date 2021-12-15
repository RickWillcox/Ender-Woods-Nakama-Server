// Quests
function GetQuestsDatabase(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    var quests : {} = _getCollection(nk, "json_database_files", "quests")
    if (Object.keys(quests).length == 0)
    {
        return JSON.stringify({success : false, message: "Quest database not initialized"})
    }
    return JSON.stringify({success: true, result: quests})
}

// Items 
function getItemsDatabase(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    var items : {} = _getCollection(nk, "json_database_files", "items")
    if (Object.keys(items).length == 0)
    {
        return JSON.stringify({success : false, message: "Item database not initialized"})
    }
    return JSON.stringify({success: true, result: items})
}

// Item Modifiers
function getItemModifiersDatabase(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    var items : {} = _getCollection(nk, "json_database_files", "modifiers")
    if (Object.keys(items).length == 0)
    {
        return JSON.stringify({success : false, message: "Item database not initialized"})
    }
    return JSON.stringify({success: true, result: items})
}

// Crafting 
function GetCraftingRecipesDatabase(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    var items : {} = _getCollection(nk, "json_database_files", "recipes")
    if (Object.keys(items).length == 0)
    {
        return JSON.stringify({success : false, message: "Item database not initialized"})
    }
    return JSON.stringify({success: true, result: items})
}