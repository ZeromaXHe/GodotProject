extends Control

var color_arr = [Color.black, Color.white, Color.green, Color.red, Color.blue, Color.gold,
		Color.purple]
var now_choose_item = null


func _ready() -> void:
	for item in $Panel2/UserItems.get_children():
		item.connect("gui_input", self, "_on_gui_input", [item])
	for item in $Panel/Items.get_children():
		item.connect("gui_input", self, "_on_gui_input", [item])


func _input(event: InputEvent) -> void:
	if now_choose_item != null:
		now_choose_item.position = get_local_mouse_position()


func _on_gui_input(event, item):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		print(item)
		var child = item.get_children()
		if child.size() == 1:
			if now_choose_item == null:
				now_choose_item = child[0].duplicate()
				now_choose_item.position = get_local_mouse_position()
				get_tree().get_root().add_child(now_choose_item)
				child[0].queue_free()
			else:
				var now_item = now_choose_item.duplicate()
				now_item.position = Vector2(30, 30)
				item.add_child(now_item)
				now_choose_item.queue_free()
				
				now_choose_item = child[0].duplicate()
				now_choose_item.position = get_local_mouse_position()
				get_tree().get_root().add_child(now_choose_item)
				child[0].queue_free()
		else:
			var dup = now_choose_item.duplicate()
			dup.position = Vector2(30, 30)
			item.add_child(dup)
			now_choose_item.queue_free()
			now_choose_item = null;
	pass


func _on_AddItem_pressed() -> void:
	for i in range(1, 6):
		var item = get_node("Panel2/UserItems/Item" + str(i))
		if (item.get_children().size() < 1):
			var sprite = Sprite.new()
			sprite.texture = load("res://icon.png")
			sprite.modulate = color_arr[i]
			sprite.position = Vector2(30, 30)
			sprite.scale = Vector2(0.7, 0.7)
			item.add_child(sprite)
	pass # Replace with function body.


func _on_Open_pressed() -> void:
	$Panel.visible = !$Panel.visible
	pass # Replace with function body.
