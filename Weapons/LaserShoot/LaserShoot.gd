extends Weapon

class_name LaserShoot

func _physics_process(delta):
	var direction = Vector2(sin(rotation), -cos(rotation))
	move_and_collide(direction.normalized() * speed * delta)

func _on_Timer_timeout():
	queue_free()
