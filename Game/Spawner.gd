extends Node2D

onready var spawn_location = $SpawnerPath/PathFollow2D

func _ready():
	FleetManager.connect("update_allies", self, "update_allies")

func _on_AsteroidTimer_timeout():
	$AsteroidTimer.spawn_element(spawn_location)

func _on_CylonTimer_timeout():
	$CylonTimer.spawn_element(spawn_location)

func _on_EnergyChargeTimer_timeout():
	$EnergyChargeTimer.spawn_element(spawn_location)
	
func update_allies(vector_scale: Vector2):
	scale = vector_scale * 3
