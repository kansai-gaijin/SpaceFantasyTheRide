extends Area2D
class_name Projectile

@onready var sprite := $AnimatedSprite2D
@onready var screen_notif := $ScreenNotif

@export var damage := 1
@export var speed := 100

func _ready():
	screen_notif.connect("screen_exited", _on_screen_exited)
	
func _on_screen_exited():
	queue_free()

func _physics_process(delta):
	position.x +=  speed * delta

func die():
	speed = speed*.4
	sprite.play("death")

func _on_animated_sprite_2d_animation_finished():
	if sprite.animation == "death":
		queue_free()
