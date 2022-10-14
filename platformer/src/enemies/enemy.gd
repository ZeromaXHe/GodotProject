extends KinematicBody2D

const gravity = 2000

export var max_speed = 50
export var acceleration = 50 / 0.2
export var dead = false

# := 可以自动指明 velocity 的类型是 Vector2
# 等于 var velocity: Vector2 = Vector2.ZERO
var velocity := Vector2.ZERO

onready var sprite: Sprite = $Sprite
onready var animation_player = $AnimationPlayer


func _on_HurtBox_hurt(hitbox) -> void:
	if not hitbox.instant_kill and animation_player.has_animation("Death"):
		animation_player.play("Death")
	else:
		queue_free()


func _on_VisibilityEnabler2D_viewport_entered(_viewport: Viewport) -> void:
	var enabler = $VisibilityEnabler2D
	enabler.process_parent = false
	enabler.physics_process_parent = false
	enabler.pause_animations = false
