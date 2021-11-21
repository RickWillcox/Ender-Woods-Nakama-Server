function InitModule(ctx : nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, intializer: nkruntime.Initializer) {
    logger.info("JS module loaded");
    intializer.registerRpc("healthcheck", rpcHealthCheck);
    intializer.registerRpc("add_world_server_id", addWorldServerId);
}