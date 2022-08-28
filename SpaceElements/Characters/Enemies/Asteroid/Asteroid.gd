extends Weapon

class_name Asteroid

onready var _sprite = $Sprite
var speed_rotation : float

func _ready():
	speed_rotation = (PI / ((randi() % 5 + 5) * 10)) * (1 if (randi() % 6 < 3) else -1)

func _physics_process(delta):
	var direction = Vector2(sin(rotation), -cos(rotation))
	_sprite.rotate(speed_rotation)
	move_and_collide(direction.normalized() * speed * delta)

func _on_VisibilityNotifier2D_screen_exited():
	$Timer.start()

func _on_Asteroid_body_entered(body):
	if not body is StaticBody2D:
		body.impact_damage(damage_caused)
		dead()

func impact_damage(damage: int):
	if damage_caused != 1:
		divide_asteroid()
	dead()

func _on_Timer_timeout():
	if not $VisibilityNotifier2D.is_on_screen():
		queue_free()

func divide_asteroid():
	for i in range(damage_caused):
		var asteroid = duplicate() as Asteroid
		asteroid.set_scale_damage(1)
		asteroid.global_rotation = i*PI/2
		asteroid.set_as_toplevel(true)
		asteroid.global_position = global_position
		get_parent().add_child(asteroid)

func set_scale_damage(value: int):
	damage_caused = value
	scale = Vector2.ONE * value
