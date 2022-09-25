extends Control

var node = load("res://graph_edit/graph_node.tscn")
var init_pos = Vector2(50, 50)
var cur_idx = 0
var copy_nodes = []

onready var graph = $GraphEdit
onready var popup: Panel = $PanelPopup

func _on_ButtonAdd_pressed() -> void:
	var new_node = node.instance()
	new_node.offset += init_pos + cur_idx * Vector2(30, 30)
	new_node.title = "节点" + str(cur_idx)
	graph.add_child(new_node)
	cur_idx += 1
	pass # Replace with function body.


func _on_GraphEdit_connection_request(from: String, from_slot: int, to: String, to_slot: int) -> void:
	graph.connect_node(from, from_slot, to, to_slot)
	pass # Replace with function body.


func _on_GraphEdit_disconnection_request(from: String, from_slot: int, to: String, to_slot: int) -> void:
	graph.disconnect_node(from, from_slot, to, to_slot)
	pass # Replace with function body.


func _on_ButtonCalc_pressed() -> void:
	var list = graph.get_connection_list()
	var res = 0
	for i in list:
		if(res == 0):
			res = graph.get_node(i.from).get_node("SpinBox").value
		res += graph.get_node(i.to).get_node("SpinBox").value
	$Label.text = "结果：" + str(res)
	pass # Replace with function body.


func get_selected_graph_node() -> Array:
	var nodes = []
	for node in graph.get_children():
		if node is GraphNode and node.selected:
			nodes.append(node)
	return nodes


func _on_GraphEdit_delete_nodes_request(nodes: Array) -> void:
	for node in get_selected_graph_node():
		node.queue_free()
	pass # Replace with function body.


func duplicate_nodes(nodes: Array) -> void:
	for node in nodes:
		node.selected = false
		var dn = node.duplicate()
		dn.title += " - 副本"
		dn.offset += Vector2(300, 0)
		graph.add_child(dn)
		dn.selected = true

func _on_GraphEdit_duplicate_nodes_request() -> void:
	duplicate_nodes(get_selected_graph_node())
	pass # Replace with function body.


func _on_GraphEdit_copy_nodes_request() -> void:
	copy_nodes = get_selected_graph_node()
	pass # Replace with function body.


func _on_GraphEdit_paste_nodes_request() -> void:
	duplicate_nodes(copy_nodes)
	pass # Replace with function body.


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		var iemb: InputEventMouseButton = event
		if (
				iemb.position.x < popup.rect_position.x
				or iemb.position.x > popup.rect_position.x + popup.rect_size.x
				or iemb.position.y < popup.rect_position.y
				or iemb.position.y > popup.rect_position.y + popup.rect_size.y
		):
			init_popup()


func _on_GraphEdit_popup_request(position: Vector2) -> void:
	popup.visible = true
	popup.set_position(position)
	pass # Replace with function body.


func init_popup() -> void:
	popup.visible = false
	popup.set_position(Vector2(-150, 0))


func _on_ButtonDelete_pressed() -> void:
	_on_GraphEdit_delete_nodes_request([])
	pass # Replace with function body.
