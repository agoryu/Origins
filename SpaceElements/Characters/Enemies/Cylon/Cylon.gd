extends Enemy

onready var missile_constructor = preload("res://SpaceElements/Weapons/Missile/Missile.tscn")

var weapon_used = 0

func _ready():
	_weapon = $Weapons

func _physics_process(delta):
	var direction_angle = Game.player.global_position.direction_to(self.global_position).angle() - PI / 2
	_sprite.global_rotation = direction_angle
	_weapon.global_rotation = direction_angle

func _on_MissileTimer_timeout():
	var missile = missile_constructor.instance()
	missile.global_position = _weapon.get_child(weapon_used).global_position
	missile._target = Game.player
	
	weapon_used = (weapon_used + 1) % 2
	get_tree().root.add_child(missile)
