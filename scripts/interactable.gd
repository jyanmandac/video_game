extends Area2D

@export var message := "Hello"
@export var is_task := false
@export var question := ""
@export var answer := ""

var player_in_range := false
var done := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = true

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = false

func _unhandled_input(event: InputEvent) -> void:
	if not player_in_range or not Game.running:
		return
	if event.is_action_pressed("interact"):
		if is_task and not done and question != "":
			TaskPopup.open(question, answer, _on_solved)
		else:
			HUD.show_message(message)

func _on_solved() -> void:
	done = true
	Game.complete_task()
