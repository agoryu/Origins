extends Camera2D

onready var _timer : Timer = $Timer
onready var _tween : Tween = $Tween

var shake_amount : float = 5.0
var can_move : bool = true

func _ready():
	Game.connect("shake_screen", self, "begin_shake")
	FleetManager.connect("update_allies", self, "update_allies")
	FleetManager.connect("loose_ally", self, "loose_ally")
	FleetManager.connect("set_player", self, "set_player")

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
		
	if can_move:
		global_position = FleetManager.player.global_position

func begin_shake():
	_timer.start()

func update_allies(vector_zoom: Vector2):
	_tween.interpolate_property(self, "zoom", zoom, vector_zoom, 1.0, Tween.TRANS_LINEAR)
	_tween.start()
	
func loose_ally(ally: Ally):
	var ally_position = ally.global_position
	var ally_radius = ally._collision.shape.radius
	Engine.time_scale = 0.1
	var vector_zoom = Vector2.ONE * (ally_radius/100.0)
	$SlowMotionStreamPlayer.play()
	_tween.interpolate_property(self, "global_position", global_position, ally_position, 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	_tween.interpolate_property(self, "zoom", zoom, vector_zoom, 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	_tween.start()
	can_move = false
	yield(_tween, "tween_all_completed")
	ally.queue_free()
	_tween.interpolate_property(self, "global_position", ally_position, FleetManager.player.global_position, 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	_tween.interpolate_property(self, "zoom", vector_zoom, FleetManager.calc_vector_radius(), 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	_tween.start()
	can_move = true
	Engine.time_scale = 1.0
	
func set_player():
	_tween.interpolate_property(self, "global_position", global_position, FleetManager.player.global_position, 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	_tween.start()
	can_move = false
	yield(_tween, "tween_all_completed")
	can_move = true
	
