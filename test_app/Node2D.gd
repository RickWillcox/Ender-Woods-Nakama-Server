extends Node2D

enum ReadPermissions { NO_READ, OWNER_READ, PUBLIC_READ}
enum WritePermissions { NO_WRITE, OWNER_WRITE}
onready var client : NakamaClient = AuthConnection.client
var server_id = "WorldServer1"
var username = ""
func _ready():
	var email = "hello@example.com"
	var password = "somesupersecretpassword"
	# Use yield(client.function(), "completed") to wait for the request to complete. Hopefully, Godot will implement the await keyword in future versions.
	var session : NakamaSession = yield(client.authenticate_email_async(email, password), "completed")
	print("SESSION1:")
	print(session.token) # Print the session or exception
	print(session.username)
	username = session.username
	print(session.user_id)
	var save_game = "{ \"progress\": 50 }"
	var my_stats = "{ \"skill\": 24 }"
	var can_read = 1
	var can_write = 1
	var version = ""
	var acks : NakamaAPI.ApiStorageObjectAcks = yield(client.write_storage_objects_async(session, [
		NakamaWriteStorageObject.new("saves", "savegame", can_read, can_write, save_game, version),
		NakamaWriteStorageObject.new("stats", "skills", can_read, can_write, my_stats, version)
	]), "completed")
	if acks.is_exception():
		print("An error occured: %s" % acks)
		return
	print("Successfully stored objects:")
	for a in acks.acks:
		print("%s" % a)
		
	# testing connection by server. server_id should be a super-secret password only available on the server itself!
	# maybe add a hook rpc before registering to mark that this user is "server1"
	var create_account = true
	session = yield(client.authenticate_custom_async(server_id, server_id, create_account), "completed")
	
	# shouldnt cause exception
	print("PRINTING SESSION")
	print(session)
	
	test_server_connection()


func test_server_connection():
	var session : NakamaSession = yield(client.authenticate_custom_async(server_id, server_id), "completed")
	print("PRINTING SESSION2")
	print(session)
	
	# now session is session data of world server. Can we read some users data? 
	var usernames = [username]
	var result : NakamaAPI.ApiUsers = yield(client.get_users_async(session, [], usernames, []), "completed")
	if result.is_exception():
		print("An error occured: %s" % result)
		assert(false)
	# We got the user account, SUCCESS!. Users will have to share their user_ids or UUID with world server
	# TODO: is it safe?. Maybe even share their session object with world server? World would be able to 
	# access their private data like email. I guess its necessary, considering nakama server also has access
	# to private data
	for u in result.users:
		print("User id '%s' username '%s'" % [u.id, u.username])
	
	
	# How to verify that whoever is sending the session object is actually logged in?
	# On world server, we can attempt to check if user is logged it, calling any endpoint
	# with an expired/invalid session object would give an error
	# Maybe just try to get users data with his own session token, if it fails user is not authenticated
	# an example
	# It might not be safe to send the session object via RPC. What other options are there?
	
	# on world server we need to get some data from the storage enginge of nakama
	# Some of this data includes item data, statistics data, maybe monster data
	# Any user can create public data in the nakama storage engine. Maybe well
	# have a script that generates it like Auth does now, make it public so any 
	# world server or user could access it. We could also make sure no user is
	# able to get that data if we want by using an api hook. If user id belongs to
	# user, return nil (in Lua thats disable endpoint). if its a server 
	# return the data
	
	# Here is some public data generation
	var items = {
		0 : {"attack": 5, "defense":4, "type" : 5},
		1 : {"attack": 5, "defense":4, "type" : 5},
		2 : {"attack": 5, "defense":4, "type" : 5},
		3 : {"attack": 5, "defense":4, "type" : 5},
		4 : {"attack": 5, "defense":4, "type" : 5},
	}
	
	var collection = "item_data" # like database in mysql
	var key = "items" # like table in mysql
	
	var acks : NakamaAPI.ApiStorageObjectAcks = yield(client.write_storage_objects_async(session, [
		NakamaWriteStorageObject.new(
			collection, 
			key,
			ReadPermissions.PUBLIC_READ,
			WritePermissions.OWNER_WRITE,
			JSON.print(items),
			""),
	]), "completed")
	if acks.is_exception():
		print("An error occured: %s" % acks)
		return
	print("Successfully stored objects:")
	for a in acks.acks:
		print("%s" % a)
		
	# Try to get public data as user:
	var email = "hello@example.com"
	var password = "somesupersecretpassword"
	# Use yield(client.function(), "completed") to wait for the request to complete. Hopefully, Godot will implement the await keyword in future versions.
	var session2 : NakamaSession = yield(client.authenticate_email_async(email, password), "completed")
	var objs = yield(client.list_storage_objects_async(session2, collection), "completed")
	print(objs.objects)
	print("\n\n\n\n\n")
	print(objs.objects[0].value)
	print(typeof(objs.objects[0].value))
	# should we JSON parse first?
	var json_result = JSON.parse(objs.objects[0].value).result
	print(json_result)
	
	# the only problem with json is that keys cannot be integers. So need to use string in the converted
	# dictionary
	print(json_result["0"]["attack"])
	
	# We could od this:
	var new_dict = {}
	for string_key in json_result:
		var int_key = int(string_key)
		new_dict[int_key] = json_result[string_key]
	
	# should give the same result
	print(new_dict[0]["attack"])
	assert(new_dict[0]["attack"] == json_result["0"]["attack"])
	
	
	# what about user inventory? It should be possible to modify using world server only
	# Maybe do it through RPCs?
	# RPCs for inventory modification should only be callable by world server
	# Since there will be more than one world server and one nakama auth, world
	# the inventory data should be stored under user with null uuid (basically meaning us)
	
