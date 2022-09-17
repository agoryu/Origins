extends Control

class_name Sound

onready var _main_audio_player = $MainAudioPlayer

func _ready():
	Game.connect("make_pause", self, "reduce_sound")
	Game.connect("level_up", self, "open_level_up_menu")
	Game.connect("close_menu", self, "reset_sound")
	_main_audio_player.play()
	
func open_level_up_menu(xp, max_xp_value, warning_level):
	reduce_sound()

func reduce_sound():
	_main_audio_player.volume_db = -10.0
	
func reset_sound():
	_main_audio_player.volume_db = 0.0
