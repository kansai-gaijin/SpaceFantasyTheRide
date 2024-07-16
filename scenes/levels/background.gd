extends ParallaxBackground

@export var scrollSpeed = -10;
@export var scrollSpeedY = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta: float) -> void:
	scroll_base_offset.x += scrollSpeed*delta;
	scroll_base_offset.y += scrollSpeedY*delta;
