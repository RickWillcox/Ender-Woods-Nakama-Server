// null uuid is the nakama server uid
var null_uuid : string = "00000000-0000-0000-0000-000000000000"


function _getItems(nk : nkruntime.Nakama) : {[key : string] : any} {
    var keys : nkruntime.StorageReadRequest[] = [
        {
            collection: "item_database",
            key : "items",
            userId : null_uuid
        }
    ];

    var result : nkruntime.StorageObject[] = nk.storageRead(keys)
    var items : {[key : string] : any} = result[0].value

    return items
}

function _saveItems(nk : nkruntime.Nakama, items : {[key : string] : any}) : void {
    var keys : nkruntime.StorageWriteRequest[] = [
        {
            collection: "item_database",
            key : "items",
            userId : null_uuid,
            value : items
        }
    ];


    nk.storageWrite(keys)
}

function getItems(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    /*if (ctx.userId)
    {
        return JSON.stringify({success: false})
    }*/
    var items : {} = _getItems(nk);

    return JSON.stringify({success: true, items: items})
}


type Item = {
    item_id : Number;
    item_name : string;
    item_category : Number;
    stack_size : Number;
    base_modifiers : string;
};


function addItem(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    var items : { [key: string]: any } = _getItems(nk)
    logger.info(payload)
    var item : Item = JSON.parse(payload);
    try
    {
        var item_id : string = item.item_id.toString()
        if (items[item_id] == undefined)
        {
            items[item_id] = {
                item_name : item.item_name,
                item_category: item.item_category,
                stack_size: item.stack_size,
                base_modfiers: item.base_modifiers
            };
            _saveItems(nk, items)
            return JSON.stringify({success : true})
        }
    }
    catch (e)
    {
        return JSON.stringify({success : false, error: (<Error>e).message})
    }

    return JSON.stringify({success : false})
}

function removeAllItems(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string) : string {
    var items : { [key: string] : any } = {}
    _saveItems(nk, items)
    return JSON.stringify({success : true})
}