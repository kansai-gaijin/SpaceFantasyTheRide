extends Node2D
class_name HealthSystem

signal death

@onready var invincible_timer = $InvincibilityBuffer

@export_group("health")
@export var max_health:int = 100
@export var health:int

@export_group("invincibility")
@export var allow_invincible:bool = false
@export var invincible_time:int = 3
var can_take_damage = true
var dead = false

func _ready():
	health = max_health
	invincible_timer.timeout.connect(_handle_invincible_time)

func take_damage(damage:int):
	if can_take_damage && !dead:
		health = clamp(health - damage, 0, max_health)
		if health <= 0:
			death.emit()
			dead = true
		elif allow_invincible:
			invincible_timer.wait_time = invincible_time
			can_take_damage = false
			invincible_timer.start()
		
func heal(amount:int):
	health = clamp(health + amount, 0, max_health)

func _handle_invincible_time():
	can_take_damage = true
