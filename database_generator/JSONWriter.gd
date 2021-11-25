extends Node
class_name JSONWriter
var dict = {}

func clear():
	dict = {}

func add_item(item_id : int, item_name: String, item_category : int, stack_size : int, base_modifiers: Dictionary):
	dict[item_id] = {
		"item_name" : item_name,
		"item_category" : item_category,
		"stack_size" : stack_size,
		"base_modifiers" : base_modifiers
	}
	
func add_recipe(id : int, type : int, required_level : int, materials : Dictionary, result_item_id : int):
	dict[id] = {
		"type" : type,
		"required_level" : required_level,
		"materials" : materials,
		"result_item_id" : result_item_id
	}
	
func add_modifier(id : int, type : int,  modifiers : Dictionary, display : String, item_category_restrictions : int):
	dict[id] = {
		"type" : type,
		"modifiers" : modifiers,
		"display" : display,
		"item_category_restrictions" : item_category_restrictions
	}
	
func save(collection, key, output_filename):
	var file = File.new()
	file.open(output_filename, File.WRITE)
	var query_string = \
"""
[
  {
	"collection": "%s",
	"key": "%s",
	"permission_read": 2,
	"permission_write": 0,
	"user_id": "00000000-0000-0000-0000-000000000000",
	"value": %s
  }
]
"""
	var full_query = query_string % [collection, key, JSON.print(dict)]
	file.store_string(full_query)
	file.close()
