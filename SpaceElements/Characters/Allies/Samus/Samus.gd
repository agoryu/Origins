extends Ally

class_name Samus

onready var photon_shoot_constructor = preload("res://SpaceElements/Weapons/Photon/Photon.tscn")
onready var photon_sprite = preload("res://SpaceElements/Characters/Allies/Samus/bomb.png")

var _photon_scale = 1

func _ready():
	on_ready()
	first_group = "samus"

func _physics_process(delta):
	if is_player:
		player_move()
	else:
		move_ally()

func add_damage(value: int):
	damage_added += value
	
func lvl_up():
	.lvl_up()
	if lvl >= MAX_LVL:
		_photon_scale = 2

func _on_ShootTimer_timeout():
	var photon_shoot = photon_shoot_constructor.instance()
	photon_shoot.global_position = $Weapons/PhotonPosition.global_position
	photon_shoot.rotation = _sprite.rotation
	photon_shoot.is_stop = true
	photon_shoot.get_node("Sprite").texture = photon_sprite
	add_child(photon_shoot)
	photon_shoot.set_as_toplevel(true)
	photon_shoot.scale *= _photon_scale
