extends Area2D

signal hit

func _on_Hitbox_area_entered(hurtbox: Area2D) -> void:
	emit_signal("hit")
	hurtbox.emit_signal("hurt")
