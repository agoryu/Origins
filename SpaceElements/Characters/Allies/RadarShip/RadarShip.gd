extends Ally

onready var _radar_direction_constructor = preload("res://SpaceElements/Characters/Allies/RadarShip/RadarDirection.tscn")
onready var _detection_zone : Area2D = $DetectionZone
onready var _radar_direction_node = $RadarDirection
onready var _radar = $Sprite/Radar

func _physics_process(delta):
	if is_player:
		player_move()
	else:
		move_ally(delta, FleetManager.player)
		
	_radar.rotate(PI/30.0)


func _on_RadarTimer_timeout():
	if _radar_direction_node.get_child_count() >= damage_caused:
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
