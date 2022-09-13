extends Bonus

onready var _animation_player = $AnimationPlayer

#func _ready():
#	var warning_level = Game.warning_level
#	if warning_level < 10:
#		value = 1
#	elif warning_level >= 10 and warning_level < 20:
#		value = randi() % 5 + 1
#	else:
#		 value = randi() % 10 + 1
#
#	scale += Vector2.ONE * (value / 10)

func _physics_process(delta: float) -> void:
	attract(delta)

func _on_XP_body_entered(body):
	Game.add_xp(value)
	_animation_player.play("pickup")
