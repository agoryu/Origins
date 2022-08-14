extends Node2D

onready var _sprite = $Sprite

const INITIAL_DISTANCE : float = 800.0

var target = null
var _initial_sprite_scale : Vector2 = Vector2.ZERO

func _ready():
	_initial_sprite_scale = _sprite.scale

func _physics_process(delta):
	if is_instance_valid(target):
		global_rotation = target.global_position.direction_to(self.global_position).angle() - PI / 2
		scale_sprite()
	else:
		queue_free()
		
func scale_sprite():
	var distance = global_position.distance_to(target.global_position) / INITIAL_DISTANCE
	distance = clamp(distance, 0.5, 1.2)
	_sprite.scale = _initial_sprite_scale * distance
