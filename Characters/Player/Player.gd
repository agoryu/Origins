extends Character

class_name Player

export var move_force_amplitude := 1000.0

onready var laser_shoot_constructore = preload("res://Weapons/LaserShoot/LaserShoot.tscn")
onready var _sprite = $Sprite
onready var _weapons = $Weapons

var weapon_uses : int = 1

func _ready():
	Game.player = self
	life.max_value = 3
	life.value = 3

func _physics_process(delta: float) -> void:
	var direction = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

	applied_force = direction * move_force_amplitude
	_sprite.rotation = linear_velocity.angle() + PI / 2
	_weapons.rotation = _sprite.rotation

func _on_Player_body_entered(body):
	self._on_Character_body_entered(body)
	$AnimationPlayer.play("impact")
	if life.value <= 0:
		Game.game_over()

func _on_ShootTimer_timeout():
	var laser_shoot = laser_shoot_constructore.instance()
	laser_shoot.global_position = _weapons.get_child(weapon_uses).global_position
	laser_shoot.rotation = _sprite.rotation
	add_child(laser_shoot)
	laser_shoot.set_as_toplevel(true)
	weapon_uses = (weapon_uses + 1) % 2
