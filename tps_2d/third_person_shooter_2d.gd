extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("TPS 2D start")

var count = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	count += 1
	if (count % 60 == 0):
		print("1s passed")
	pass


func _on_Player_shoot(Bullet, direction, location) -> void:
	var b = Bullet.instance()
	add_child(b)
	b.rotation = direction
	b.position = location
	b.velocity = b.velocity.rotated(direction)
