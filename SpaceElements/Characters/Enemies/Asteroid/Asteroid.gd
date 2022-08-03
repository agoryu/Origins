extends Weapon

class_name Asteroid

func _physics_process(delta):
	var direction = Vector2(sin(rotation), -cos(rotation))
	move_and_collide(direction.normalized() * speed * delta)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Asteroid_body_entered(body: SpaceElement):
	body.impact_damage(damage_caused)
	dead()

func impact_damage(damage: int):
	dead()
