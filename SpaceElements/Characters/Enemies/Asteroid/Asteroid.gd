extends Weapon

class_name Asteroid

func _physics_process(delta):
	var direction = Vector2(sin(rotation), -cos(rotation))
	move_and_collide(direction.normalized() * speed * delta)

func _on_VisibilityNotifier2D_screen_exited():
	$Timer.start()

func _on_Asteroid_body_entered(body: SpaceElement):
	body.impact_damage(damage_caused)
	dead()

func impact_damage(damage: int):
	dead()

func _on_Timer_timeout():
	if not $VisibilityNotifier2D.is_on_screen():
		queue_free()
