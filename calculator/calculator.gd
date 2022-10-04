extends Control

func _ready() -> void:
	for item in $Num.get_children():
		item.connect("pressed", self, "_button_press", [item.text])
	pass


func _button_press(txt: String) -> void:
	print(txt)
	match txt:
		"=":
			var result = calc($Label.text)
			if typeof(result) == TYPE_BOOL:
				$Label.text = "Error"
			else:
				$Label.text = str(result)
		"C":
			$Label.text = ""
		_:
			$Label.text += txt
	pass


func calc(input):
	var script = GDScript.new()
	script.set_source_code("tool\nfunc eval():\n\treturn(" + input + ")")
	var err = script.reload()
	if err != OK:
		return false
	var obj = Reference.new()
	obj.set_script(script)
	var result = obj.eval()
	return result
