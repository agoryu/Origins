extends ColorRect

onready var _animation_player = $AnimationPlayer
var is_playing = false

func _ready():
	Game.connect("start_alert", self, "start_alert")
	Game.connect("stop_alert", self, "stop_alert")
	
func _process(delta):
	if Game.is_on_pause:
		_animation_player.stop(false)
	elif not _animation_player.is_playing() and is_playing:
		_animation_player.play()
	
func start_alert():
	_animation_player.play("begin_alert")
	is_playing = true
	
func stop_alert():
	_animation_player.stop()
	is_playing = false
