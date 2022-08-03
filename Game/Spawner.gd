extends Node2D

onready var spawn_location = $SpawnerPath/PathFollow2D

func _on_AsteroidTimer_timeout():
	$AsteroidTimer.spawn_element(spawn_location)

func _on_CylonTimer_timeout():
	$CylonTimer.spawn_element(spawn_location)

func _on_EnergyChargeTimer_timeout():
	$EnergyChargeTimer.spawn_element(spawn_location)
