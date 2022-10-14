extends Node2D

func _ready() -> void:
	var tilemap = $TileMap
	var rect = tilemap.get_used_rect()
	var bounds = Rect2(
		rect.position.x * tilemap.cell_size.x,
		rect.position.y * tilemap.cell_size.y,
		rect.size.x * tilemap.cell_size.x,
		rect.size.y * tilemap.cell_size.y
	)
	var camera = $Player/Camera2D
	camera.limit_bottom = bounds.end.y
	camera.limit_left = bounds.position.x
	camera.limit_right = bounds.end.x
	
	var shape = RectangleShape2D.new()
	shape.extents = Vector2(bounds.size.x / 2, tilemap.cell_size.y / 2)
	$Hitbox/CollisionShape2D.shape = shape
	$Hitbox.position = Vector2(
		bounds.position.x + bounds.size.x / 2,
		bounds.end.y + tilemap.cell_size.y * 2
	)
	
	add_child(preload("res://platformer/src/ui/hud.tscn").instance())
