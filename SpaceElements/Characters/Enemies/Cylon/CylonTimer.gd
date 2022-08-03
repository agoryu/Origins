extends Timer

onready var cylon_constructor = preload("res://SpaceElements/Characters/Enemies/Cylon/Cylon.tscn")

const WAIT_TIME: int = 20

var is_first_cylon: bool = true

func spawn_element(spawn_location: PathFollow2D):
	if is_first_cylon:
		is_first_cylon = false
		self.wait_time = WAIT_TIME
		
	for i in range(2):
		var cylon = cylon_constructor.instance()
		spawn_location.offset = randi()
		cylon.global_position = spawn_location.global_position
		
		cylon.set_as_toplevel(true)
		add_child(cylon)
