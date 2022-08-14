extends Button

func _on_Continue_button_up():
	Game.stop_pause()
	Game.is_on_pause = false
