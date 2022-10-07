extends Camera2D

var screen_shake_start = false
var shake_intensity = 0

func _ready() -> void:
	Global.camera = self


func _exit_tree() -> void:
	Global.camera = null


func _process(delta: float) -> void:
	zoom = lerp(zoom, Vector2(1, 1), 0.3)
	if screen_shake_start:
		global_position += delta * Vector2(
				rand_range(-shake_intensity, shake_intensity),
				rand_range(-shake_intensity, shake_intensity))
	else:
		global_position = lerp(global_position, Vector2(0, 0), 0.3)


func screen_shake(intensity, time):
	zoom = Vector2(1, 1) - Vector2(intensity * 0.0015, intensity * 0.0015)
	shake_intensity = intensity
	$ScreenShakeTimer.wait_time = time
	$ScreenShakeTimer.start()
	screen_shake_start = true


func _on_ScreenShakeTimer_timeout() -> void:
	screen_shake_start = false
