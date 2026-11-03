extends Area2D

@export_file("*.tscn") var target_scene: String
@export var target_spawn_name := ""

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		Game.spawn_name = target_spawn_name
		get_tree().change_scene_to_file.call_deferred(target_scene)
