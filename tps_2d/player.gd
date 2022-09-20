extends RigidBody2D

signal shoot(bullet, direction, location)

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var Bullet = preload("res://tps_2d/bullet.tscn")


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	pass # Replace with function body.


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("shoot", Bullet, rotation, position)
	elif event is InputEventKey:
		if event.scancode == KEY_SPACE and event.pressed:
			apply_central_impulse(Vector2.UP * 2000)
		if event.scancode == KEY_LEFT and event.pressed:
			apply_central_impulse(Vector2.LEFT * 2000)
		if event.scancode == KEY_RIGHT and event.pressed:
			apply_central_impulse(Vector2.RIGHT * 2000)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	look_at(get_global_mouse_position())
