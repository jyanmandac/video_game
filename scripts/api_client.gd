extends Node

signal history_loaded(rows)

const BASE_URL = "http://127.0.0.1:8000"

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func send_result(level: int, outcome: String):
	print("sending: ", level, " ", outcome)
	var http = HTTPRequest.new()
	add_child(http)
	http.request_completed.connect(func(_r, code, _h, resp):
		print("saved: ", code, " ", resp.get_string_from_utf8())
		http.queue_free()
	)
	var payload = JSON.stringify({"level": level, "result": outcome})
	var err = http.request(BASE_URL + "/history", ["Content-Type: application/json"], HTTPClient.METHOD_POST, payload)
	if err != OK:
		print("request failed to start: ", err)

func get_history():
	var http = HTTPRequest.new()
	add_child(http)
	http.request_completed.connect(func(_r, code, _h, resp):
		if code == 200:
			history_loaded.emit(JSON.parse_string(resp.get_string_from_utf8()))
		http.queue_free()
	)
	http.request(BASE_URL + "/history")
