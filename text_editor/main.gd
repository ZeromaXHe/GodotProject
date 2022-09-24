extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MenuButtonFile.get_popup().connect("id_pressed", self, "_file_id_press")
	$MenuButtonHelp.get_popup().connect("id_pressed", self, "_help_id_press")
	pass # Replace with function body.


func _file_id_press(id: int) -> void:
	match id:
		0:
			$FileDialogOpen.popup()
		1:
			$FileDialogSave.popup()
		2:
			get_tree().quit()
	pass


func _help_id_press(id) -> void:
	if id == 0:
		$WindowDialogAbout.popup()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_FileDialogOpen_file_selected(path):
	var file: File = File.new()
	file.open(path, File.READ)
	$TextEdit.text = file.get_as_text()
	file.close()
	pass # Replace with function body.


func _on_FileDialogSave_file_selected(path):
	var file: File = File.new()
	file.open(path, File.WRITE)
	file.store_string($TextEdit.text)
	file.close()
	pass # Replace with function body.
