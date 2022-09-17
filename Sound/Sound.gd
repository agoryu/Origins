extends Control

class_name Sound

onready var _main_audio_player = $MainAudioPlayer

func _ready():
	_main_audio_player.play()
