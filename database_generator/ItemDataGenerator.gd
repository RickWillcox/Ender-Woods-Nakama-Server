extends Node
class_name ItemDatabaseGenerator
onready var http_requester : HTTPRequester = $HTTPRequester
onready var json_writer : JSONWriter = $JSONWriter

enum { NON_CONSUMABLE = 0, CONSUMABLE}
var category = ItemDatabase.Category
# items start from id = 1
var equippable_item_ids = ItemDatabase.EquippableItemIds
var material_item_ids = ItemDatabase.MaterialItemIds
var recipe_ids = ItemDatabase.RecipeIds

class Item:
	var id : int
	var item_name : String
	var consumable : int
	var file_name : String
	var item_category : int
	var stack_size : int
	var base_modifiers : Dictionary
	func _init(_id, _item_name, _item_category, _base_modifiers, _stack_size = 1, _consumable = NON_CONSUMABLE):
		id = _id
		item_name = _item_name
		consumable = _consumable
		base_modifiers = _base_modifiers
		item_category = _item_category
		stack_size = _stack_size
		file_name = str(id) + "_" + _item_name + ".png"
	static func new_equippable(_id, _item_category, _base_modifiers):
		var _item_name = (ItemDatabase.EquippableItemIds.keys()[_id - ItemDatabase.FIRST_EQUIPPABLE_ITEM_ID] as String).to_lower()
		return Item.new(_id, _item_name, _item_category, _base_modifiers)
	static func new_material(_id, _stack_size, category):
		var _item_name = (ItemDatabase.MaterialItemIds.keys()[_id - ItemDatabase.FIRST_MATERIAL_ITEM_ID] as String).to_lower()
		return Item.new(_id, _item_name, category, {}, _stack_size)
	func save(json_writer : JSONWriter):
		json_writer.add_item(id, item_name, item_category, stack_size, base_modifiers)
		
class Recipe:
	var id : int
	var type : int
	var required_level : int
	var materials : Dictionary
	var result_item_id : int
	func _init(_id : int, _type : int, _required_level : int, _materials : Dictionary, _result_item_id : int):
		id = _id
		type = _type
		required_level = required_level
		materials = _materials
		result_item_id = _result_item_id
	static func new_smelting(_id : int, _required_level : int, _materials : Dictionary, _result_item_id : int):
		return Recipe.new(_id, ItemDatabase.RecipeType.SMELTING, _required_level, _materials, _result_item_id)
	func save(json_writer : JSONWriter):
		json_writer.add_recipe(id, type, required_level, materials, result_item_id)

enum ModifierType { PREFIX = 0, SUFFIX = 1}

class ItemModifier:
	var id : int
	var type : int
	var modifiers : Dictionary
	var display : String
	var item_category_restrictions : int
	func _init(_id : int, _item_category_restrictions, _display : String, _type : int, _modifiers : Dictionary):
		id = _id
		type = _type
		display = _display
		modifiers = _modifiers
		item_category_restrictions = _item_category_restrictions
	func save(json_writer : JSONWriter):
		json_writer.add_modifier(id, type, modifiers, display, item_category_restrictions)

func _ready():
	generate_item_database()
	generate_recipe_database()
	generate_itemmodifier_database()

func generate_item_database():
	
	var items = []
	# Equippable items
	#                                ID                           		CATEGORY		BASE_MODIFIERS
	# COPPER ITEMS
	items.append(Item.new_equippable(equippable_item_ids.COPPER_HELMET, category.HELMET, {"defense":5}))
	items.append(Item.new_equippable(equippable_item_ids.COPPER_CHEST, category.BODY_ARMOR, {"defense":10}))
	items.append(Item.new_equippable(equippable_item_ids.COPPER_GLOVES, category.GLOVES, {"attack":4, "defense":2}))
	items.append(Item.new_equippable(equippable_item_ids.COPPER_LEGGINGS, category.LEGGINGS, {"defense":8}))
	items.append(Item.new_equippable(equippable_item_ids.COPPER_BOOTS, category.BOOTS, {"attack":2, "defense":2}))
	items.append(Item.new_equippable(equippable_item_ids.COPPER_SWORD, category.SWORD, {"attack":10}))
	items.append(Item.new_equippable(equippable_item_ids.COPPER_SHIELD, category.SHIELD, {"defense":10}))
	items.append(Item.new_equippable(equippable_item_ids.COPPER_RING, category.RING, {"defense":4, "attack":4}))
	items.append(Item.new_equippable(equippable_item_ids.COPPER_AMULET, category.AMULET, {"defense":5, "attack":5}))
	items.append(Item.new_equippable(equippable_item_ids.COPPER_PICKAXE, category.PICKAXE, {"defense":5, "attack":5}))
	items.append(Item.new_equippable(equippable_item_ids.COPPER_AXE, category.AXE, {"defense":5, "attack":5}))
	
	# IRON ITEMS
	items.append(Item.new_equippable(equippable_item_ids.IRON_HELMET, category.HELMET, {"defense":5}))
	items.append(Item.new_equippable(equippable_item_ids.IRON_CHEST, category.BODY_ARMOR, {"defense":10}))
	items.append(Item.new_equippable(equippable_item_ids.IRON_GLOVES, category.GLOVES, {"attack":4, "defense":2}))
	items.append(Item.new_equippable(equippable_item_ids.IRON_LEGGINGS, category.LEGGINGS, {"defense":8}))
	items.append(Item.new_equippable(equippable_item_ids.IRON_BOOTS, category.BOOTS, {"attack":2, "defense":2}))
	items.append(Item.new_equippable(equippable_item_ids.IRON_SWORD, category.SWORD, {"attack":10}))
	items.append(Item.new_equippable(equippable_item_ids.IRON_SHIELD, category.SHIELD, {"defense":10}))
	items.append(Item.new_equippable(equippable_item_ids.IRON_RING, category.RING, {"defense":4, "attack":4}))
	items.append(Item.new_equippable(equippable_item_ids.IRON_AMULET, category.AMULET, {"defense":5, "attack":5}))
	items.append(Item.new_equippable(equippable_item_ids.IRON_PICKAXE, category.PICKAXE, {"defense":5, "attack":5}))
	items.append(Item.new_equippable(equippable_item_ids.IRON_AXE, category.AXE, {"defense":5, "attack":5}))
	
	# BRONZE ITEMS
	items.append(Item.new_equippable(equippable_item_ids.BRONZE_HELMET, category.HELMET, {"defense":5}))
	items.append(Item.new_equippable(equippable_item_ids.BRONZE_CHEST, category.BODY_ARMOR, {"defense":10}))
	items.append(Item.new_equippable(equippable_item_ids.BRONZE_GLOVES, category.GLOVES, {"attack":4, "defense":2}))
	items.append(Item.new_equippable(equippable_item_ids.BRONZE_LEGGINGS, category.LEGGINGS, {"defense":8}))
	items.append(Item.new_equippable(equippable_item_ids.BRONZE_BOOTS, category.BOOTS, {"attack":2, "defense":2}))
	items.append(Item.new_equippable(equippable_item_ids.BRONZE_SWORD, category.SWORD, {"attack":10}))
	items.append(Item.new_equippable(equippable_item_ids.BRONZE_SHIELD, category.SHIELD, {"defense":10}))
	items.append(Item.new_equippable(equippable_item_ids.BRONZE_RING, category.RING, {"defense":4, "attack":4}))
	items.append(Item.new_equippable(equippable_item_ids.BRONZE_AMULET, category.AMULET, {"defense":5, "attack":5}))
	items.append(Item.new_equippable(equippable_item_ids.BRONZE_PICKAXE, category.PICKAXE, {"defense":5, "attack":5}))
	items.append(Item.new_equippable(equippable_item_ids.BRONZE_AXE, category.AXE, {"defense":5, "attack":5}))
	
	# SILVER ITEMS
	items.append(Item.new_equippable(equippable_item_ids.SILVER_HELMET, category.HELMET, {"defense":5}))
	items.append(Item.new_equippable(equippable_item_ids.SILVER_CHEST, category.BODY_ARMOR, {"defense":10}))
	items.append(Item.new_equippable(equippable_item_ids.SILVER_GLOVES, category.GLOVES, {"attack":4, "defense":2}))
	items.append(Item.new_equippable(equippable_item_ids.SILVER_LEGGINGS, category.LEGGINGS, {"defense":8}))
	items.append(Item.new_equippable(equippable_item_ids.SILVER_BOOTS, category.BOOTS, {"attack":2, "defense":2}))
	items.append(Item.new_equippable(equippable_item_ids.SILVER_SWORD, category.SWORD, {"attack":10}))
	items.append(Item.new_equippable(equippable_item_ids.SILVER_SHIELD, category.SHIELD, {"defense":10}))
	items.append(Item.new_equippable(equippable_item_ids.SILVER_RING, category.RING, {"defense":4, "attack":4}))
	items.append(Item.new_equippable(equippable_item_ids.SILVER_AMULET, category.AMULET, {"defense":5, "attack":5}))
	items.append(Item.new_equippable(equippable_item_ids.SILVER_PICKAXE, category.PICKAXE, {"defense":5, "attack":5}))
	items.append(Item.new_equippable(equippable_item_ids.SILVER_AXE, category.AXE, {"defense":5, "attack":5}))
	
	# GOLD ITEMS
	items.append(Item.new_equippable(equippable_item_ids.GOLD_HELMET, category.HELMET, {"defense":5}))
	items.append(Item.new_equippable(equippable_item_ids.GOLD_CHEST, category.BODY_ARMOR, {"defense":10}))
	items.append(Item.new_equippable(equippable_item_ids.GOLD_GLOVES, category.GLOVES, {"attack":4, "defense":2}))
	items.append(Item.new_equippable(equippable_item_ids.GOLD_LEGGINGS, category.LEGGINGS, {"defense":8}))
	items.append(Item.new_equippable(equippable_item_ids.GOLD_BOOTS, category.BOOTS, {"attack":2, "defense":2}))
	items.append(Item.new_equippable(equippable_item_ids.GOLD_SWORD, category.SWORD, {"attack":10}))
	items.append(Item.new_equippable(equippable_item_ids.GOLD_SHIELD, category.SHIELD, {"defense":10}))
	items.append(Item.new_equippable(equippable_item_ids.GOLD_RING, category.RING, {"defense":4, "attack":4}))
	items.append(Item.new_equippable(equippable_item_ids.GOLD_AMULET, category.AMULET, {"defense":5, "attack":5}))
	items.append(Item.new_equippable(equippable_item_ids.GOLD_PICKAXE, category.PICKAXE, {"defense":5, "attack":5}))
	items.append(Item.new_equippable(equippable_item_ids.GOLD_AXE, category.AXE, {"defense":5, "attack":5}))
	
	
	# Materials
	#                             ID                       stack_size
	items.append(Item.new_material(material_item_ids.COPPER_ORE, 20, category.ORE))
	items.append(Item.new_material(material_item_ids.TIN_ORE, 20, category.ORE))
	items.append(Item.new_material(material_item_ids.IRON_ORE, 20, category.ORE))
	items.append(Item.new_material(material_item_ids.COAL, 40, category.ORE))
	items.append(Item.new_material(material_item_ids.SILVER_ORE, 20, category.ORE))
	items.append(Item.new_material(material_item_ids.GOLD_ORE, 20, category.ORE))
	
	items.append(Item.new_material(material_item_ids.COPPER_BAR, 20, category.METAL_BAR))
	items.append(Item.new_material(material_item_ids.BRONZE_BAR, 20, category.METAL_BAR))
	items.append(Item.new_material(material_item_ids.IRON_BAR, 20, category.METAL_BAR))
	items.append(Item.new_material(material_item_ids.SILVER_BAR, 20, category.METAL_BAR))
	items.append(Item.new_material(material_item_ids.GOLD_BAR, 20, category.METAL_BAR))
	
	json_writer.clear()
	# save items into database
	for item in items:
		(item as Item).save(json_writer)
		
	json_writer.save("json_database_files", "items", "items.json")

func generate_recipe_database():
	var recipes = []
	
	recipes.append(Recipe.new_smelting(recipe_ids.SMELT_COPPER, 0, { material_item_ids.COPPER_ORE: 2 }, material_item_ids.COPPER_BAR))
	recipes.append(Recipe.new_smelting(recipe_ids.SMELT_BRONZE, 0, { material_item_ids.COPPER_ORE: 1, material_item_ids.TIN_ORE: 1 }, material_item_ids.BRONZE_BAR))
	recipes.append(Recipe.new_smelting(recipe_ids.SMELT_IRON, 0, { material_item_ids.IRON_ORE: 2, material_item_ids.COAL : 1 }, material_item_ids.IRON_BAR))
	recipes.append(Recipe.new_smelting(recipe_ids.SMELT_SILVER, 0, { material_item_ids.SILVER_ORE: 2, material_item_ids.COAL : 1 }, material_item_ids.SILVER_BAR))
	recipes.append(Recipe.new_smelting(recipe_ids.SMELT_GOLD, 0, { material_item_ids.GOLD_ORE: 2, material_item_ids.COAL : 1 }, material_item_ids.GOLD_BAR))
	
	json_writer.clear()
	for recipe in recipes:
		(recipe as Recipe).save(json_writer)
	json_writer.save("json_database_files", "recipes", "recipes.json")


	
const FIRST_MODIFIER_ID = 1 # 0 - reserved, means no modifier
enum ItemModifierIds { SHARP = FIRST_MODIFIER_ID,
						BLUNT,
						OF_WISDOM,
						REINFORCED,
						}
						
enum ItemCategoryRestrictions { NONE = 0,
								WEAPON_ONLY, # Weapons only
								WEARABLE_ONLY } # Only stuff like armor, rings

func generate_itemmodifier_database():
									
	var item_modifier_definitions = [
		# ID					# TYPE				# Item category restrictions		#Display	# modifier effect
		[ItemModifierIds.SHARP, ModifierType.PREFIX, ItemCategoryRestrictions.WEAPON_ONLY, "Sharp", {"attack" : 1}],
		[ItemModifierIds.BLUNT, ModifierType.PREFIX, ItemCategoryRestrictions.WEAPON_ONLY, "Blunt", {"attack" : -1}],
		[ItemModifierIds.OF_WISDOM, ModifierType.SUFFIX, ItemCategoryRestrictions.NONE, "of Wisdom", {"wisdom": 1}],
		[ItemModifierIds.REINFORCED, ModifierType.PREFIX, ItemCategoryRestrictions.WEARABLE_ONLY, "Reinforced", {"defense":2}]
	]
	
	json_writer.clear()
	for item_modifier in item_modifier_definitions:
		ItemModifier.new(item_modifier[0], item_modifier[2], item_modifier[3], item_modifier[1], item_modifier[4]).save(json_writer)
	json_writer.save("json_database_files", "modifiers", "item_modifiers.json")
