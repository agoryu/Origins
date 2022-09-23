extends Ally

onready var _radar_direction_constructor = preload("res://SpaceElements/Characters/Allies/RadarShip/RadarDirection.tscn")
onready var _detection_zone : Area2D = $DetectionZone
onready var _audio_player = $AudioStreamPlayer2D
onready var _radar_direction_node = $RadarDirection
onready var _tween = $Tween
onready var _halo = $HaloCircle
onready var _radar = $Sprite/Radar

var activate_absorption : bool = false

func _ready():
	_fire = $Sprite/Fire
	first_group = "radar"
	_initial_speed = speed

func _physics_process(delta):
	if is_player:
		player_move()
	else:
		move_ally()
	_radar.rotate(PI/30.0)

func _on_RadarTimer_timeout():
	activate_radar()
	if _radar_direction_node.get_child_count() >= damage_caused + damage_added:
		return
		
	var target_list = []
	for i in range(damage_caused):
		var target = find_target(target_list)
		if target != null:
			target_list.push_back(target)
			var radar_direction = _radar_direction_constructor.instance()
			_radar_direction_node.add_child(radar_direction)
			radar_direction.target = target
		
func find_target(target_list: Array) -> SpaceElement:
	var distance_tmp = -1
	var target = null
	for elt in _detection_zone.get_overlapping_areas():
		var distance_collision_body = global_position.distance_to(elt.global_position)
		if (
			(target == null or distance_tmp > distance_collision_body) 
			and target_list.find(elt) == -1
			and elt as EnergyCharge
		):
			target = elt
			distance_tmp = distance_collision_body
	return target
	
func activate_radar():
	_audio_player.play()
	_tween.interpolate_property(_halo, "size", 0, 200, 1.0)
	_tween.interpolate_property(_halo, "modulate", Color.white, Color.transparent, 1.0)
	_tween.start()
	if activate_absorption:
		_detection_zone.monitorable = true
	
func lvl_up():
	.lvl_up()
	if lvl >= MAX_LVL:
		activate_absorption = true

func _on_CollisionZone_body_exited(body):
	if (body is Ally 
		and body.get_parent() != self 
		and not is_player 
	):
		end_collision()

func _on_CollisionZone_body_entered(body):
	if (body is Ally 
		and body.get_parent() != self 
		and not is_player 
	):
		collision_detected(body)

func _on_Tween_tween_all_completed():
	if activate_absorption:
		_detection_zone.monitorable = false
