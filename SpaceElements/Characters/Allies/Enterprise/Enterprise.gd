extends Ally

onready var _laser_beam_timer = $LaserBeamTimer
onready var _laser_beam = $Sprite/LaserBeam

func _physics_process(delta):
	if is_player:
		player_move()
	else:
		move_ally(delta, Game.player)

func _on_LaserBeamTimer_timeout():
	_laser_beam.set_is_casting(true)

func add_damage(value: int):
	damage_added += value
	_laser_beam.damage_caused += value
