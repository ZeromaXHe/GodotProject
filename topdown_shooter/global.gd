extends Node

var node_creation_parent = null
var player = null
var camera = null

var points = 0
var high_points = 0


func instance_node(node, location, parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance


func save():
	var save_dict = {
		"high_points": high_points
	}
	return save_dict


func save_game():
	var game_save = File.new()
	game_save.open_encrypted_with_pass("user://topdown_shooter.save", File.WRITE, "enc")
	game_save.store_line(to_json(save()))
	game_save.close()


func load_game():
	var game_save = File.new()
	if not game_save.file_exists("user://topdown_shooter.save"):
		print("Error! We don't have a save file to load")
		return
	game_save.open_encrypted_with_pass("user://topdown_shooter.save", File.READ, "enc")
	var current_line = parse_json(game_save.get_line())
	high_points = current_line["high_points"]
	game_save.close()
