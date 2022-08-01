extends Node2D

const BLAST_IMPULSE := 500.0

func _ready():
	$AnimationPlayer.play("explode")
	
func _on_Area2D_body_entered(body):
	var colliders = $Area2D.get_overlapping_bodies()
	for body in colliders:
		if body is RigidBody2D:
			var direction := global_position.direction_to(body.global_position)
			body.apply_central_impulse(BLAST_IMPULSE * direction)
