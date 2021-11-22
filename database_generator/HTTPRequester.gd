extends Node
class_name HTTPRequester
signal http_request_done

# I'll leave this here for future reference but this has a problem with concurrency
func request_add_item(item_id : int, item_name: String, item_category : int, stack_size : int, base_modifiers: String):
	var request_body = {
		"item_id": item_id,
		"stack_size" : stack_size,
		"item_category" : item_category,
		"item_name" : item_name,
		"base_modifiers" : base_modifiers
	}
	
	var request_body_string = JSON.print(JSON.print(request_body))
	var request = HTTPRequest.new()
	add_child(request)
	request.connect("request_completed", self, "_http_request_completed")
	var error = request.request(
		"http://127.0.0.1:7350/v2/rpc/add_item?http_key=defaulthttpkey",
		[],
		true, HTTPClient.METHOD_POST, request_body_string)
	if error != OK:
		push_error("An error occurred in the HTTP request.")
	yield(self, "http_request_done")
	yield(get_tree().create_timer(2), "timeout")
	request.queue_free()
	
	var result = JSON.parse(http_response["payload"]).result["success"]
	assert(result == true)
	
func request_remove_all_items():
	var request : HTTPRequest = HTTPRequest.new()
	add_child(request)
	request.connect("request_completed", self, "_http_request_completed")
	var error = request.request("http://127.0.0.1:7350/v2/rpc/remove_all_items?http_key=defaulthttpkey")
	if error != OK:
		push_error("An error occurred in the HTTP request.")
	yield(self, "http_request_done")
	request.queue_free()
	var result = JSON.parse(http_response["payload"]).result["success"]
	assert(result == true)

var http_response
# Called when the HTTP request is completed.
func _http_request_completed(result, response_code, headers, body):
	var response = parse_json(body.get_string_from_utf8())
	http_response = response
	print(response)
	emit_signal("http_request_done")
