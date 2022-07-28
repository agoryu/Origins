extends Character

onready var _laser_beam_timer = $LaserBeamTimer
onready var _laser_beam = $Sprite/LaserBeam
onready var _shoot_position = $Sprite/ShootPosition
onready var _sprite = $Sprite

var player
var is_too_far : bool = false

func _ready():
	player = Game.player
	
func _physics_process(delta):
	follow_player(delta)
	
func follow_player(delta):
	if is_too_far:
		if player.position.distance_to(position) > 0:
			linear_velocity = player.linear_velocity * 2
		else:
			linear_velocity = player.linear_velocity / 2
	else:
		linear_velocity = player.linear_velocity
	$Sprite.rotation = player.sprite.rotation

func _on_Ally1_body_entered(body):
	if body.collision_layer != 1:
		self._on_Character_body_entered(body)
		$AnimationPlayer.play("impact")
		if life.value <= 0:
			queue_free()

func _on_MaximalDistance_area_entered(area):
	if area.get_parent() is Player:
		is_too_far = false

func _on_MaximalDistance_area_exited(area):
	if area.get_parent() is Player:
		is_too_far = true

func _on_LaserBeamTimer_timeout():
	_laser_beam.set_is_casting(true)
