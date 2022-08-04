extends Ally

onready var _laser_beam_timer = $LaserBeamTimer
onready var _laser_beam = $Sprite/LaserBeam

var player

func _ready():
	player = Game.player
	_life.display()

func _physics_process(delta):
	move_ally(delta, player)

func _on_LaserBeamTimer_timeout():
	_laser_beam.set_is_casting(true)

func add_damage(value: int):
	damage_added += value
	_laser_beam.damage_caused += value
