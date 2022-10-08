extends Sprite

export(String) var player_variable_modify
export(float) var player_variable_set
export(float) var power_up_cooldown = 2

func _on_Hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		var player = area.get_parent()
		player.set(player_variable_modify, player_variable_set)
		var cooldown_timer: Timer = player.get_node("PowerUpCooldown")
		if player.power_up_reset.find(name) != null:
			player.power_up_reset.append(name)
			cooldown_timer.wait_time = power_up_cooldown
			cooldown_timer.start()
		else:
			cooldown_timer.wait_time += power_up_cooldown
		queue_free()
