extends Node

func _ready():
	ApiClient.history_loaded.connect(func(rows): print(rows))
	ApiClient.get_history()
