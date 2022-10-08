extends Sprite

var speed = 150
var velocity = Vector2()
var bullet = preload("res://topdown_shooter/bullet.tscn")
var shootable = true
var dead = false
var damage = 1
var reload_speed = 0.1
var default_damage = damage
var default_reload_speed = reload_speed
var power_up_reset = []

func _ready() -> void:
	Global.player = self


func _exit_tree() -> void:
	Global.player = null


func _process(delta: float) -> void:
	if dead:
		return
	velocity.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	velocity.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	velocity = velocity.normalized()
	
	global_position += speed * velocity * delta
	global_position.x = clamp(global_position.x, 0, OS.window_size.x)
	global_position.y = clamp(global_position.y, 0, OS.window_size.y)
	
	if Input.is_action_pressed("mouse") and Global.node_creation_parent != null and shootable:
		var bullet_instance = Global.instance_node(bullet, global_position, Global.node_creation_parent)
		bullet_instance.damage = damage
		$ReloadTimer.start()
		shootable = false


func _on_ReloadTimer_timeout() -> void:
	shootable = true
	$ReloadTimer.wait_time = reload_speed


func _on_Hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		dead = true
		visible = false
		Global.save_game()
		yield(get_tree().create_timer(1.5), "timeout")
		get_tree().reload_current_scene()


func _on_PowerUpCooldown_timeout() -> void:
	if power_up_reset.find("PowerUpReload") != null:
		reload_speed = default_reload_speed
		power_up_reset.erase("PowerUpReload")
	if power_up_reset.find("PowerUpDamage") != null:
		damage = default_damage
		power_up_reset.erase("PowerUpDamage")
