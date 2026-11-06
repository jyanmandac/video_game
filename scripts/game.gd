extends Node

signal time_up
signal all_tasks_done

var spawn_name := ""
var time_left := 0.0
var running := false
var tasks_total := 2
var tasks_done := 0
var current_level := 1

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	print("Game autoload ready")
	start_timer(60.0)

func start_timer(seconds: float) -> void:
	time_left = seconds
	running = true

func complete_task() -> void:
	tasks_done += 1
	print("Tasks done: ", tasks_done, "/", tasks_total)
	if tasks_done >= tasks_total:
		running = false
		all_tasks_done.emit()
		ApiClient.send_result(current_level, "pass")

func _process(delta: float) -> void:
	if not running:
		return
	time_left -= delta
	if time_left <= 0.0:
		time_left = 0.0
		running = false
		time_up.emit()
		print("Time is up")
		ApiClient.send_result(current_level, "fail")
