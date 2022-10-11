extends Node

onready var animation_player = $AnimationPlayer

func reload_world():
	animation_player.play_backwards("FadeIn")
	yield(animation_player, "animation_finished")
	get_tree().reload_current_scene()
	animation_player.play("FadeIn")
