extends ColorRect

func _draw():
	for x in rand_range(50, 100):
		draw_circle(Vector2(rand_range(0, 2000), rand_range(0, 2000)), rand_range(0.5, 4.0), Color(1,1,1,randf()))
