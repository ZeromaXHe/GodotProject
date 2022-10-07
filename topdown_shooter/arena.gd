extends Node2D


var enemy_1 = preload("res://topdown_shooter/enemy.tscn")

func _ready() -> void:
	Global.node_creation_parent = self
	Global.points = 0


func _exit_tree() -> void:
	Global.node_creation_parent = null


func _on_EnemySpawnTimer_timeout() -> void:
	var x = rand_range(-OS.window_size.x / 2, OS.window_size.x * 1.5)
	var y = rand_range(0, OS.window_size.y)
	if x < 0:
		x = -64
	elif x > OS.window_size.x:
		x = OS.window_size.x + 64
	else:
		y = randi() % 2 * (OS.window_size.y + 128) - 64
	var enemy_position = Vector2(x, y)
	print("spwan enemy at " + str(enemy_position))
	Global.instance_node(enemy_1, enemy_position, self)


func _on_DifficultyTimer_timeout() -> void:
	if $EnemySpawnTimer.wait_time > 0.5:
		$EnemySpawnTimer.wait_time -= 0.1
