extends "res://topdown_shooter/enemy_core.gd"

func _process(delta: float) -> void:
	basic_movement_towards_player(delta)
