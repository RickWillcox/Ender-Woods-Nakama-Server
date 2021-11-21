// null uuid is the nakama server uid
var null_uuid : string = "00000000-0000-0000-0000-000000000000"


function getWorldServerIds(nk : nkruntime.Nakama) : string[] {
    var keys : nkruntime.StorageReadRequest[] = [
        {
            collection: "world_servers",
            key : "world_server_ids",
            userId : null_uuid
        }
    ];

    var world_server_ids : string[] = []
    var result : nkruntime.StorageObject[] = nk.storageRead(keys)

    result.forEach(res => {world_server_ids = res.value["world_server_ids"]})

    return world_server_ids
}

function saveWorldServerIds(nk : nkruntime.Nakama, world_server_ids : string[]) : void {
    var keys : nkruntime.StorageWriteRequest[] = [
        {
            collection: "world_servers",
            key : "world_server_ids",
            userId : null_uuid,
            value : {"world_server_ids" : world_server_ids}
        }
    ];

    nk.storageWrite(keys)
}

function addWorldServerId(ctx: nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, payload: string): string {
    var world_server_id : string = JSON.parse(payload).world_server_id
    var world_server_ids : string[] = getWorldServerIds(nk);

    if (world_server_ids.indexOf(world_server_id) == -1)
    {
        world_server_ids.push(world_server_id)
        saveWorldServerIds(nk, world_server_ids);
        return JSON.stringify({success: true})
    }
    
    return JSON.stringify({success: false})
}
