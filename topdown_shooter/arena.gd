extends Node2D

export(Array, PackedScene) var enemies
export(Array, PackedScene) var power_ups

func _ready() -> void:
	Global.node_creation_parent = self
	Global.points = 0


func _exit_tree() -> void:
	Global.node_creation_parent = null


func _on_EnemySpawnTimer_timeout() -> void:
	if enemies.size() == 0:
		return
	var x = rand_range(-OS.window_size.x / 2, OS.window_size.x * 1.5)
	var y = rand_range(0, OS.window_size.y)
	if x < 0:
		x = -64
	elif x > OS.window_size.x:
		x = OS.window_size.x + 64
	else:
		y = randi() % 2 * (OS.window_size.y + 128) - 64
	var enemy_position = Vector2(x, y)
	var enemy_index = randi() % enemies.size()
	print("spwan enemy " + str(enemy_index) + " at " + str(enemy_position))
	Global.instance_node(enemies[enemy_index], enemy_position, self)


func _on_DifficultyTimer_timeout() -> void:
	if $EnemySpawnTimer.wait_time > 0.5:
		$EnemySpawnTimer.wait_time -= 0.025


func _on_PowerUpSpawnTimer_timeout() -> void:
	if power_ups.size() == 0:
		return
	var power_up_index = randi() % power_ups.size()
	var power_up_position = Vector2(rand_range(0, OS.window_size.x), rand_range(0, OS.window_size.y))
	print("spwan power-up " + str(power_up_index) + " at " + str(power_up_position))
	Global.instance_node(power_ups[power_up_index], power_up_position, self)
