extends RayCast2D

class_name LaserBeam2D

onready var fill := $FillLine
onready var tween := $Tween
onready var casting_particles = $CastingParticle
onready var beam_particles = $BeamParticle
onready var collision_particles = $CollisionParticle
onready var timer = $Timer
onready var audiostream = $AudioStreamPlayer2D

onready var line_width: float = fill.width

export var cast_speed := 7000.0
export var max_length := 3000
export var growth_time := 0.1

export var damage : int = 1

var is_casting : bool = false setget set_is_casting

func _ready():
	set_physics_process(false)
	fill.points[1] = Vector2.ZERO

func _physics_process(delta: float) -> void:
	cast_to = (cast_to + Vector2.RIGHT * cast_speed * delta).clamped(max_length)
	cast_beam()
	
func cast_beam():
	var cast_point = cast_to
	force_raycast_update()
	
	collision_particles.emitting = is_colliding()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
		collision_particles.global_rotation = get_collision_normal().angle()
		collision_particles.position = cast_point
		var collider = get_collider() as Character
		collider.impact_damage(damage)
		
	fill.points[1] = cast_point
	beam_particles.position = cast_point * 0.5
	beam_particles.process_material.emission_box_extents.x = cast_point.length() * 0.5

func appear():
	if tween.is_active():
		tween.stop_all()
	tween.interpolate_property(fill, "width", 0, line_width, growth_time * 2)
	tween.start()
	audiostream.play()
	timer.start()
	
func disappear():
	if tween.is_active():
		tween.stop_all()
	tween.interpolate_property(fill, "width", line_width, 0, growth_time)
	tween.start()

func set_is_casting(cast: bool):
	is_casting = cast
	if is_casting:
		cast_to = Vector2.ZERO
		fill.points[1] = cast_to
		appear()
	else:
		collision_particles.emitting = false
		disappear()
	
	set_physics_process(is_casting)
	casting_particles.emitting = is_casting
	beam_particles.emitting = is_casting

func _on_Timer_timeout():
	set_is_casting(false)
