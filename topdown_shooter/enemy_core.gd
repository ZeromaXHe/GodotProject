extends Sprite

export(int) var speed = 75
export(int) var hp = 3
export(int) var knockback = 600
export(int) var screen_shake = 120
export(int) var point_value = 10
onready var current_color = $ColorRect.color
var velocity = Vector2()
var stun = false
var blood_particles = preload("res://topdown_shooter/blood_particles.tscn")


func basic_movement_towards_player(delta: float) -> void:
	if Global.player != null and not stun:
		velocity = global_position.direction_to(Global.player.global_position)
		global_position += velocity * speed * delta
	elif stun:
		velocity = lerp(velocity, Vector2(0, 0), 0.3)
		global_position += velocity * delta


func  _process(_delta: float) -> void:
	if hp <= 0:
		if Global.camera != null:
			Global.camera.screen_shake(screen_shake, 0.2)
		Global.points += point_value
		if Global.node_creation_parent != null:
			var blood_particles_instance = Global.instance_node(
					blood_particles, global_position, Global.node_creation_parent)
			blood_particles_instance.rotation = velocity.angle()
			blood_particles_instance.modulate = Color.from_hsv(
					current_color.h, 0.75, current_color.v)
		queue_free()


func _on_Hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("EnemyDamager") and not stun:
		stun = true
		velocity *= -knockback
		hp -= area.get_parent().damage
		$ColorRect.color = Color.white
		$StunTimer.start()
		area.get_parent().queue_free()


func _on_StunTimer_timeout() -> void:
	$ColorRect.color = current_color
	stun = false
