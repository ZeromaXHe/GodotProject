extends GraphNode


func _on_GraphNode_close_request():
	# 删除节点
	queue_free()
	pass # Replace with function body.


func _on_GraphNode_resize_request(new_minsize: Vector2) -> void:
	rect_size = new_minsize
	pass # Replace with function body.
