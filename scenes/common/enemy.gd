extends Area2D
class_name Enemy

@export var collision_damage = 1

func die():
	queue_free()

func take_damage(amount):
	$Health.take_damage(amount)

func _on_body_entered(body):
	if body is Player:
		var player : Player = body as Player
		var player_health : HealthSystem = player.get_node("Health") as HealthSystem
		if player && player_health.can_take_damage && !player_health.dead:
			player.take_damage(collision_damage)
			take_damage(1)

func _on_health_death():
	die()

func _on_area_entered(area):
	if area is Projectile:
		var projectile: Projectile = area as Projectile
		take_damage(projectile.damage)
		projectile.die()
