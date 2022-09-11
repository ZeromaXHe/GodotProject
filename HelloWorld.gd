extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Hello World!")

var count = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	count += 1
	if (count % 60 == 0):
		print("1s")
	pass
