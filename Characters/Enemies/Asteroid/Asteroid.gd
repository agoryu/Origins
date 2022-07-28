extends Enemy

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Asteroid_body_entered(body):
	if body is Weapon:
		body.queue_free()
	dead()

func impact_damage(damage: int):
	_on_Asteroid_body_entered(null)
