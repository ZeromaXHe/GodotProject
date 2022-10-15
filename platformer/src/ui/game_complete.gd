extends Control

onready var time_value = $UI/Stats/TimeValue
onready var deaths_value = $UI/Stats/DeathsValue
onready var coins_value = $UI/Stats/CoinsValue


func _ready() -> void:
	var duration = PlatformerGlobals.completed_at - PlatformerGlobals.started_at
	var minutes = duration / 60
	var seconds = duration % 60
	time_value.text = "%d:%02d" % [minutes, seconds]
	deaths_value.text = str(PlatformerGlobals.deaths)
	coins_value.text = str(PlatformerGlobals.get_coins())


func _input(event: InputEvent) -> void:
	if event.is_pressed():
		PlatformerGlobals.back_to_title()
