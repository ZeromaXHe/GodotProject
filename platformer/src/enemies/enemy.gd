extends KinematicBody2D

const gravity = 2000

onready var sprite: Sprite = $Sprite
onready var animation_player = $AnimationPlayer


func _on_HurtBox_hurt() -> void:
	if animation_player.has_animation("Death"):
		animation_player.play("Death")
	else:
		queue_free()
