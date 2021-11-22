function InitModule(ctx : nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, intializer: nkruntime.Initializer) {
    logger.info("JS module loaded");
    intializer.registerRpc("healthcheck", rpcHealthCheck);
    intializer.registerRpc("get_items", getItems);
    intializer.registerRpc("add_item", addItem);
    intializer.registerRpc("remove_all_items", removeAllItems);
}