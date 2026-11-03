extends CharacterBody2D

@export var speed: float = 100.0
@export var idle_animation: String = "idle"
@export var run_animation: String = "run"

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	add_to_group("player")
	if Game.spawn_name != "":
		var marker = get_parent().get_node_or_null(Game.spawn_name)
		if marker:
			global_position = marker.global_position

func _play(anim_name: String) -> void:
	if animated_sprite.sprite_frames.has_animation(anim_name):
		animated_sprite.play(anim_name)

func _physics_process(_delta: float) -> void:
	# Get 2D input vector (WASD / Arrow Keys)
	var input_direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	# Apply velocity directly without gravity
	velocity = input_direction * speed

	# Update sprite animations and flip direction
	if input_direction != Vector2.ZERO:
		_play(run_animation)
		if input_direction.x != 0:
			animated_sprite.flip_h = (input_direction.x < 0)
	else:
		_play(idle_animation)

	move_and_slide()
