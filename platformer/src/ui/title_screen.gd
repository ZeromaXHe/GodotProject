extends Control

onready var transitions = $UI/Menus/Transitions
onready var sfx_button = $UI/Menus/OptionsMenu/SFXButton

export var scroll_velocity = -30.0


func _ready() -> void:
	_update_buttons()


func _on_BackButton_pressed() -> void:
	transitions.play_backwards("ShowOptions")


func _on_OptionsButton_pressed() -> void:
	transitions.play("ShowOptions")


func _on_SFXButton_pressed() -> void:
	PlatformerGlobals.sfx_enabled = not PlatformerGlobals.sfx_enabled
	PlatformerGlobals.save_config()
	_update_buttons()


func _update_buttons():
	sfx_button.text = "音效：" + ("开" if PlatformerGlobals.sfx_enabled else "关")


func _on_QuitButton_pressed() -> void:
	get_tree().quit()


func _on_StartButton_pressed() -> void:
	PlatformerGlobals.start_game()
