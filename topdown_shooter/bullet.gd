extends Sprite

var velocity = Vector2(1, 0)
var speed = 250
var damage

var look_once = false

func _process(delta: float) -> void:
	if not look_once:
		look_at(get_global_mouse_position())
		look_once = true
	global_position += velocity.rotated(rotation) * speed * delta


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
