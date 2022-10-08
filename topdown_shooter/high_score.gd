extends Label

func _ready() -> void:
	Global.load_game()
	text = "High Score: " + str(Global.high_points)


func _process(delta: float) -> void:
	if Global.points > Global.high_points:
		Global.high_points = Global.points
