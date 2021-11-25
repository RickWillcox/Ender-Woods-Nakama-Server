// null uuid is the nakama server uid
var null_uuid : string = "00000000-0000-0000-0000-000000000000"

function _getCollection(nk : nkruntime.Nakama, collection : string, key : string, user_id : string = null_uuid) : {[key : string] : any} {
    var keys : nkruntime.StorageReadRequest[] = [
        {
            collection: collection,
            key : key,
            userId : user_id
        }
    ];

    var result : nkruntime.StorageObject[] = nk.storageRead(keys)
    
    if (result.length == 0)
    {
        return {}
    }

    return result[0].value
}

function _getCollectionVersion(nk : nkruntime.Nakama, collection : string, key : string, user_id : string = null_uuid) : string {
    var keys : nkruntime.StorageReadRequest[] = [
        {
            collection: collection,
            key : key,
            userId : user_id
        }
    ];

    var result : nkruntime.StorageObject[] = nk.storageRead(keys)
    
    if (result.length == 0)
    {
        return "*"
    }

    return result[0].version
}

function _setCollection(nk : nkruntime.Nakama, collection : string, key : string, version : string, value : {[key : string] : any}, user_id : string = null_uuid) : void {
    var keys : nkruntime.StorageWriteRequest[] = [
        {
            collection: collection,
            key : key,
            userId : user_id,
            value : value,
            version : version
        }
    ];
    
    nk.storageWrite(keys)
}