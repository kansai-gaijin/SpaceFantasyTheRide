extends ParallaxBackground

@export var scrollSpeed := Vector2(-10,0)

func _physics_process(delta: float) -> void:
	scroll_base_offset.x += scrollSpeed.x * delta;
	scroll_base_offset.y += scrollSpeed.y * delta;
