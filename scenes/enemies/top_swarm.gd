extends Node2D

const speed = 0.25

func _process(delta):
	var paths = $Path2D.get_children()
	for path:PathFollow2D in paths:
		path.progress_ratio += speed * delta
