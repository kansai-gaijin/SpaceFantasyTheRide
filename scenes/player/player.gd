extends CharacterBody2D
class_name Player

signal player_died

@export_group('movement')
@export var movement_speed = 200

var can_shoot = true
var can_move = true
var is_colliding_wall = false

func _ready():
	$AnimatedSprite2D.connect("animation_finished",_handle_animation_finished)
	
func _process(delta):
	if Input.is_action_pressed("shoot") && can_shoot:
		shoot()
	var collisions = get_slide_collision_count()
	if collisions:
		is_colliding_wall = true
	else:
		is_colliding_wall = false

func _physics_process(delta):
	if can_move:
		var viewport_size = get_viewport_rect().size
		var direction := Vector2(0,0)
		
		direction.x = Input.get_axis("move_left","move_right")
		direction.y = Input.get_axis("move_up","move_down")
		
		if direction.x:
			velocity.x = direction.x * movement_speed
		else:
			velocity.x = move_toward(velocity.x,0,movement_speed)
		if direction.y:
			velocity.y = direction.y * movement_speed
		else:
			velocity.y = move_toward(velocity.y,0,movement_speed)
		
		if !is_colliding_wall && !is_on_floor():
			position.x = clamp(position.x, 0 , viewport_size.x)
		
		position.y = clamp(position.y, 0 , viewport_size.y)
			
		move_and_slide()
	
func take_damage(damage):
	$Health.take_damage(damage)

func shoot():
	$Gun.shoot()
	can_shoot = false
	await get_tree().create_timer(0.2).timeout
	can_shoot = true

func _on_health_death():
	can_move = false
	$AnimatedSprite2D.play("death")
	
func _handle_animation_finished():
	if $AnimatedSprite2D.animation == "death":
		player_died.emit()
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	_on_health_death()
