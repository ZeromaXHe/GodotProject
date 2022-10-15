extends Area2D

export(String, FILE, "*.tscn") var path

func _on_Exit_body_entered(_player: Node) -> void:
	if path:
		PlatformerGlobals.go_to_world(path)
	else:
		PlatformerGlobals.complete_game()
