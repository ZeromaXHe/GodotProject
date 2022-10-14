extends Control

onready var transitions = $Transitions

func show_menu():
	if PlatformerGlobals.animation_player.is_playing():
		return
	show()
	transitions.play("Show")


func hide_menu():
	transitions.play_backwards("Show")
	yield(transitions,"animation_finished")
	hide()


func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("ui_cancel"):
		hide_menu()
		get_tree().set_input_as_handled()


func _on_ResumeButton_pressed() -> void:
	hide_menu()


func _on_QuitButton_pressed() -> void:
	hide_menu()
	PlatformerGlobals.back_to_title()


func _on_PauseMenu_visibility_changed() -> void:
	get_tree().paused = visible
