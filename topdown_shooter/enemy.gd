extends Sprite

var speed = 75
var velocity = Vector2()
var stun = false
var hp = 3
var blood_particles = preload("res://topdown_shooter/blood_particles.tscn")

func _process(delta: float) -> void:
	if Global.player != null and not stun:
		velocity = global_position.direction_to(Global.player.global_position)
	elif stun:
		velocity = lerp(velocity, Vector2(0, 0), 0.3)
	global_position += velocity * speed * delta
	
	if hp <= 0:
		if Global.camera != null:
			Global.camera.screen_shake(120, 0.2)
		Global.points += 10
		if Global.node_creation_parent != null:
			var blood_particles_instance = Global.instance_node(
					blood_particles, global_position, Global.node_creation_parent)
			blood_particles_instance.rotation = velocity.angle()
		queue_free()


func _on_Hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("EnemyDamager") and not stun:
		stun = true
		velocity *= -6
		hp -= 1
		$ColorRect.color = Color.white
		$StunTimer.start()
		area.get_parent().queue_free()


func _on_StunTimer_timeout() -> void:
	$ColorRect.color = Color("ff0036")
	stun = false
