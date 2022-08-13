extends Node2D

onready var _sprite = $Sprite

var target = null

func _physics_process(delta):
	if is_instance_valid(target):
		global_rotation = target.global_position.direction_to(self.global_position).angle() - PI / 2
	else:
		queue_free()
