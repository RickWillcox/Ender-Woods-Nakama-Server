function _getItems(nk : nkruntime.Nakama) : {[key : string] : any} {
    return _getCollection(nk, "item_database", "items")
}

function _getRecipes(nk : nkruntime.Nakama) : {[key : string] : any} {
    return _getCollection(nk, "item_database", "recipes")
}

function _getModifiers(nk : nkruntime.Nakama) : {[key : string] : any} {
    return _getCollection(nk, "item_database", "modifiers")
}

function getItems(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    var items : {} = _getItems(nk);
    return JSON.stringify({success: true, result: items})
}

function getRecipes(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    var items : {} = _getRecipes(nk);
    return JSON.stringify({success: true, result: items})
}

function getModifiers(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    var items : {} = _getModifiers(nk);
    return JSON.stringify({success: true, result: items})
}