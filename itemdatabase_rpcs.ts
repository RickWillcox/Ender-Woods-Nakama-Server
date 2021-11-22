// null uuid is the nakama server uid
var null_uuid : string = "00000000-0000-0000-0000-000000000000"

function _getCollection(nk : nkruntime.Nakama, collection : string, key : string) : {[key : string] : any} {
    var keys : nkruntime.StorageReadRequest[] = [
        {
            collection: collection,
            key : key,
            userId : null_uuid
        }
    ];

    var result : nkruntime.StorageObject[] = nk.storageRead(keys)
    
    if (result.length == 0)
    {
        return {}
    }

    return result[0].value
}

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