function InitModule(ctx : nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, intializer: nkruntime.Initializer) {
    logger.info("JS module loaded");
    intializer.registerRpc("healthcheck", rpcHealthCheck);
    intializer.registerRpc("get_items", getItems);
    intializer.registerRpc("get_recipes", getRecipes);
    intializer.registerRpc("get_modifiers", getModifiers);
}