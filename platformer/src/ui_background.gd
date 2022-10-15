extends ParallaxBackground

export var scroll_velocity = -30.0

func _process(delta: float) -> void:
	scroll_offset.x += scroll_velocity * delta
