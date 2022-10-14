extends CanvasLayer

onready var coin_label = $HBoxContainer/CoinLabel
onready var pause_menu = $PauseMenu


func _ready() -> void:
	PlatformerGlobals.connect("coins_changed", self, "_on_coins_changed")
	_on_coins_changed()


func _on_coins_changed():
	coin_label.text = str(PlatformerGlobals.get_coins())


func _on_PauseButton_pressed() -> void:
	pause_menu.show_menu()
