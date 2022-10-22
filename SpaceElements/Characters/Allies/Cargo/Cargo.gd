extends Ally

const ENERGY_GET : int = 50

func _ready():
	on_ready()
	first_group = "cargo"
	fire_scale = 3.0

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
		FleetManager.add_max_energy(energy_reserve)
		energy_reserve *= 2
		scale *= 1.5

func _on_ShootTimer_timeout():
	Game.add_energy(ENERGY_GET * (damage_added + damage_caused))
	$AnimationPlayer.play("add_energy")
