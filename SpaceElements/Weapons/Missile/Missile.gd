extends Weapon

var _target: SpaceElement = null

func _ready():
	$AudioStreamPlayer2D.play()

func _physics_process(delta):
	if _target == null or not is_instance_valid(self):
		return
		
	var direction = global_position.direction_to(_target.global_position)
	var desired_velocity = direction * speed
	var steering = desired_velocity - _velocity
	_velocity += steering / 20.0
	
	rotation = _velocity.angle() + PI / 2
	move_and_slide(_velocity)

func _on_Area2D_body_entered(body: SpaceElement):
	if body is Ally:
		body.impact_damage(damage_caused)
	else:
		dead()
