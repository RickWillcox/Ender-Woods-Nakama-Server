function InitModule(ctx : nkruntime.Context, logger: nkruntime.Logger, nk: nkruntime.Nakama, initializer: nkruntime.Initializer) {
    logger.info("JS module loaded");
    // Database related RPCs
    initializer.registerRpc("get_items_database", getItemsDatabase);
    initializer.registerRpc("get_crafting_recipes_database", GetCraftingRecipesDatabase);
    initializer.registerRpc("get_item_modifiers_database", getItemModifiersDatabase);
    initializer.registerRpc("get_quests_database", GetQuestsDatabase);


    // Player RPCS - any storage to do with a particular player
    //Inventory
    initializer.registerRpc("get_player_inventory", getPlayerInventory);
    initializer.registerRpc("set_player_inventory", setPlayerInventory);
    //Quests
    initializer.registerRpc("get_player_quests", getPlayerQuests); //TODO implement this into world
    initializer.registerRpc("set_player_quests", setPlayerQuests);
    //Stats - things like Health / EXP 
    initializer.registerRpc("get_player_stats", getPlayerStats); //TODO implement this into world
    initializer.registerRpc("set_player_stats", setPlayerStats);

    // Server RPCs - Authentication for now
    initializer.registerRpc("check_auth", checkAuth);
    initializer.registerRpc("healthcheck", rpcHealthCheck); //remove?


}
