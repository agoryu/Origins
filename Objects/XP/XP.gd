extends "res://Objects/GameObject.gd"

func _physics_process(delta: float) -> void:
	attract(delta)

func _on_XP_body_entered(body):
	Game.add_xp(value)
	queue_free()
