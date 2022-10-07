extends Sprite

var speed = 150
var velocity = Vector2()
var bullet = preload("res://topdown_shooter/bullet.tscn")
var shootable = true
var dead = false

func _ready() -> void:
	Global.player = self


func _exit_tree() -> void:
	Global.player = null


func _process(delta: float) -> void:
	if dead:
		pass
	velocity.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	velocity.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	velocity = velocity.normalized()
	
	global_position += speed * velocity * delta
	global_position.x = clamp(global_position.x, 0, OS.window_size.x)
	global_position.y = clamp(global_position.y, 0, OS.window_size.y)
	
	if Input.is_action_pressed("mouse") and Global.node_creation_parent != null and shootable:
		Global.instance_node(bullet, global_position, Global.node_creation_parent)
		$ReloadTimer.start()
		shootable = false


func _on_ReloadTimer_timeout() -> void:
	shootable = true


func _on_Hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		dead = true
		visible = false
		yield(get_tree().create_timer(1.5), "timeout")
		get_tree().reload_current_scene()
