extends Node2D

var fade = false
var alpha = 1

func _process(delta: float) -> void:
	if fade:
		alpha = lerp(alpha, 0, 0.1)
		modulate.a = alpha
		
		if alpha < 0.005:
			queue_free()

func _on_FadeOutTimer_timeout() -> void:
	fade = true
