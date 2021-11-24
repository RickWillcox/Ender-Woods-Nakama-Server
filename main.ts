function InitModule(ctx : nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, initializer: nkruntime.Initializer) {
    logger.info("JS module loaded");
    initializer.registerRpc("healthcheck", rpcHealthCheck);
    initializer.registerRpc("get_items", getItems);
    initializer.registerRpc("get_recipes", getRecipes);
    initializer.registerRpc("get_modifiers", getModifiers);

    initializer.registerRpc("get_inventory", getInventory);
    initializer.registerRpc("set_inventory", setInventory);
}