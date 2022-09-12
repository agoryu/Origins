extends Camera2D

onready var _timer : Timer = $Timer
onready var _tween : Tween = $Tween

var shake_amount : float = 5.0

func _ready():
	Game.connect("shake_screen", self, "begin_shake")
	FleetManager.connect("update_allies", self, "update_allies")

func _process(delta):
	if !_timer.is_stopped():
		offset = Vector2(
			rand_range(-1.0, 1.0) * shake_amount,
			rand_range(-1.0, 1.0) * shake_amount
		)
	else:
		offset = Vector2.ZERO
	if Input.is_action_pressed("ui_right") and offset.x < 50:
		offset.x += 5
	if Input.is_action_pressed("ui_left") and offset.x > -50:
		offset.x -= 5
		
	global_position = FleetManager.player.global_position

func begin_shake():
	_timer.start()

func update_allies(vector_zoom: Vector2):
	_tween.interpolate_property(self, "zoom", zoom, vector_zoom, 1.0, Tween.TRANS_LINEAR)
	_tween.start()
	
