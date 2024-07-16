extends Node2D

signal shot(pos:Vector2, instance)

@export var projectile:PackedScene = null

func shoot():
	var instance = projectile.instantiate()
	shot.emit(global_position, instance)
