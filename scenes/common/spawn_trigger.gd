extends Node2D
class_name SpawnTrigger

signal spawn(instance)

@export var enemy:PackedScene = null

func _on_visible_on_screen_notifier_2d_screen_entered():
	if enemy:
		var instance = enemy.instantiate()
		spawn.emit(instance)
