extends Weapon

class_name Gun

onready var _animation_player = $AnimationPlayer

func _ready():
	$AudioStreamPlayer2D.play()

func _physics_process(delta):
	var direction = Vector2(sin(rotation), -cos(rotation))
	move_and_collide(direction.normalized() * speed * delta)

func _on_Timer_timeout():
	queue_free()

func _on_Area2D_body_entered(body: SpaceElement):
	body.impact_damage(damage_caused)
	_animation_player.play("impact")
