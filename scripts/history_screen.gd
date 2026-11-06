extends Control

@onready var label = $Label

func _ready():
	ApiClient.history_loaded.connect(_on_history_loaded)
	ApiClient.get_history()

func _on_history_loaded(rows):
	var text = ""
	for row in rows:
		text += "Level %d - %s - %s\n" % [int(row["level"]), row["result"], row["play_date"]]
	label.text = text
