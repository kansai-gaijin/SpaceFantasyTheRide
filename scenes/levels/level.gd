extends Node2D
class_name Level

@onready var enemies = $Enemies
@onready var projectiles = $Projectiles

# Called when the node enters the scene tree for the first time.
func _ready():
	var enemy_triggers = get_tree().get_nodes_in_group("spawner")
	var guns = get_tree().get_nodes_in_group("guns")
	
	for trigger in enemy_triggers:
		trigger.spawn.connect(spawn_enemy)
	
	for gun in guns:
		gun.shot.connect(handle_gunshot)
	
	$Player.player_died.connect(_handle_player_death)

func spawn_enemy(instance):
	enemies.add_child(instance)

func handle_gunshot(pos,instance):
	instance.global_position = pos
	projectiles.add_child(instance)
	
func _handle_player_death():
	print("omg dead!")
	$Player.queue_free()
