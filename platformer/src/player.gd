extends KinematicBody2D

const max_speed = 350
const acceleration = max_speed / 0.2
const air_acceleration = max_speed / 0.05
const gravity = 2000
const jump_force = 880

export var dead = false

var velocity = Vector2.ZERO
var jumping = false

onready var animation_player = $AnimationPlayer
onready var sprite = $Sprite
onready var coyote_timer = $CoyoteTimer
onready var jump_request_timer = $JumpRequestTimer
onready var jump_sound = $JumpSound
onready var tween = $Tween

func _unhandled_input(event: InputEvent) -> void:
	if dead:
		return
	if event.is_action_pressed("jump"):
		jump_request_timer.start()
	# 大跳和小跳
	if velocity.y < -jump_force / 2 and event.is_action_pressed("jump"):
		velocity.y = -jump_force / 2


func _physics_process(delta: float) -> void:
	var was_on_floor = is_on_floor()
	var snap = Vector2.ZERO if jumping else Vector2.DOWN * 16
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP)
	if is_on_floor():
		# print("on floor" + str(Time.get_ticks_msec()))
		jumping = false
		if not was_on_floor:
			_tween_scale(Vector2(1.25, 0.8))
	elif was_on_floor and not jumping:
		coyote_timer.start()


func _process(delta: float) -> void:
	velocity.y += gravity * delta
	
	if dead:
		return
	
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var acc = acceleration if is_on_floor() else air_acceleration
	velocity.x = move_toward(velocity.x, direction * max_speed, acc * delta)
	
	var can_jump = is_on_floor() or coyote_timer.time_left > 0
	if can_jump and jump_request_timer.time_left > 0:
		velocity.y = -jump_force
		jumping = true
		jump_request_timer.stop()
		coyote_timer.stop()
		jump_sound.play()
	
	if jumping:
		animation_player.play("Jump")
	elif velocity.x == 0:
		animation_player.play("Idle")
	else:
		animation_player.play("Walk")
	
	sprite.flip_h = direction < 0


func _tween_scale(target):
	tween.interpolate_property(
		sprite, "scale", null, target, 0.05,
		Tween.TRANS_SINE,Tween.EASE_IN_OUT
	)
	tween.interpolate_property(
		sprite, "scale", target, Vector2.ONE, 0.1,
		Tween.TRANS_SINE,Tween.EASE_IN_OUT, 0.05
	)
	tween.start()


func _on_HurtBox_hurt(_hitbox) -> void:
	velocity.y = -jump_force
	animation_player.play("Death")
	PlatformerGlobals.reload_world()


func _on_Hitbox_hit() -> void:
	velocity.y = -jump_force / 2
	if not is_on_floor():
		_tween_scale(Vector2(1.25, 0.8))


func _on_TrailTimer_timeout() -> void:
	if velocity.x == 0:
		return
	var trail = preload("res://platformer/src/effects/trail.tscn").instance()
	get_parent().add_child(trail)
	get_parent().move_child(trail, get_index())
	
	var properties = [
		"hframes",
		"vframes",
		"frame",
		"texture",
		"global_position",
		"flip_h",
		"offset",
		"scale"
	]
	for name in properties:
		trail.set(name, sprite.get(name))
