extends CanvasLayer

@onready var label: Label = $Label
@onready var message_label: Label = $Message

var message_time := 0.0

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	Game.time_up.connect(_on_time_up)
	Game.all_tasks_done.connect(_on_all_tasks_done)

func _process(delta: float) -> void:
	if Game.running:
		var total := int(ceil(Game.time_left))
		label.text = "%d:%02d" % [floori(total / 60.0), total % 60]
	if message_time > 0.0:
		message_time -= delta
		if message_time <= 0.0:
			message_label.text = ""

func show_message(text: String) -> void:
	message_label.text = text
	message_time = 3.0

func _on_time_up() -> void:
	label.text = "TIME'S UP"
	get_tree().paused = true

func _on_all_tasks_done() -> void:
	label.text = "LAUNCH SAVED"
	get_tree().paused = true
