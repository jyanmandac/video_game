extends CanvasLayer

signal solved

@onready var question: Label = $Panel/VBox/Question
@onready var answer: LineEdit = $Panel/VBox/Answer
@onready var submit: Button = $Panel/VBox/Submit
@onready var feedback: Label = $Panel/VBox/Feedback

var correct_answer := ""
var on_solved := Callable()

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	submit.pressed.connect(_check)
	answer.text_submitted.connect(func(_text): _check())
	hide()

func open(q: String, a: String, callback := Callable()) -> void:
	question.text = q
	correct_answer = a.to_lower()
	on_solved = callback
	answer.text = ""
	feedback.text = ""
	show()
	answer.grab_focus()
	get_tree().paused = true

func _input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("ui_cancel"):
		close()

func _check() -> void:
	if answer.text.strip_edges().to_lower() == correct_answer:
		close()
		solved.emit()
		if on_solved.is_valid():
			on_solved.call()
	else:
		feedback.text = "Not quite. Try again."

func close() -> void:
	hide()
	if Game.running:
		get_tree().paused = false
