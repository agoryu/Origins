extends Weapon

signal end_shoot

class_name LaserBeam

onready var fill := $LaserBeam/FillLine
onready var tween := $LaserBeam/Tween
onready var casting_particles = $LaserBeam/CastingParticle
onready var beam_particles = $LaserBeam/BeamParticle
onready var collision_particles = $LaserBeam/CollisionParticle
onready var timer = $Timer
onready var audiostream = $AudioStreamPlayer2D
onready var laser_bream = $LaserBeam

onready var line_width: float = fill.width

export var max_length := 3000
export var growth_time := 0.1

var is_casting : bool = false setget set_is_casting

func _ready():
	set_physics_process(false)
	fill.points[1] = Vector2.ZERO

func _physics_process(delta: float) -> void:
	laser_bream.cast_to = (laser_bream.cast_to + Vector2.RIGHT * speed * delta).clamped(max_length)
	cast_beam()
	
func cast_beam():
	var cast_point = laser_bream.cast_to
	laser_bream.force_raycast_update()
	
	collision_particles.emitting = laser_bream.is_colliding()
	
	if laser_bream.is_colliding():
		cast_point = laser_bream.to_local(laser_bream.get_collision_point())
		collision_particles.global_rotation = laser_bream.get_collision_normal().angle()
		collision_particles.position = cast_point
		var collider = laser_bream.get_collider()
		collider.impact_damage(damage_caused)
		
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
		laser_bream.cast_to = Vector2.ZERO
		fill.points[1] = laser_bream.cast_to
		appear()
	else:
		collision_particles.emitting = false
		disappear()
	
	set_physics_process(is_casting)
	casting_particles.emitting = is_casting
	beam_particles.emitting = is_casting

func _on_Timer_timeout():
	set_is_casting(false)

func _on_Tween_tween_all_completed():
	emit_signal("end_shoot")
