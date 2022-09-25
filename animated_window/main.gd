extends Control



func _on_Button_pressed():
	$AnimationPlayer.play("PanelAnim")
	pass # Replace with function body.


func _on_ButtonClose_pressed():
	$AnimationPlayer.play_backwards("PanelAnim")
	pass # Replace with function body.
