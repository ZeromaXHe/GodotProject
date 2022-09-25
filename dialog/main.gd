extends Control


var text_arr = ["测试用的语句。","该语句用于测试对话框是否正常运行，","所以其实只要求是长语句随便打就好了"]
var text_speed = 0.1
var cur_idx = 0
var ready_next = true

onready var dialog_box = $DialogBox
onready var label = $DialogBox/RichTextLabel
onready var tween = $DialogBox/Tween


func _on_Button_pressed() -> void:
	showText()
	pass # Replace with function body.


func showText() -> void:
	dialog_box.visible = true
	ready_next = false

	label.text = text_arr[cur_idx]
	label.percent_visible = 0

	var time = text_speed * text_arr[cur_idx].length()
	tween.interpolate_property(label, "percent_visible", 0, 1, time,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()


func _input(event: InputEvent) -> void:
	# 需要在“项目 - 项目设置 - 键位映射”中添加 mouse 动作
	if Input.is_action_just_pressed("mouse") and dialog_box.visible == true:
		if ready_next:
			cur_idx += 1
			if cur_idx == text_arr.size():
				dialog_box.visible = false
				cur_idx = 0
			else:
				showText()
		else:
			label.percent_visible = 1
			tween.stop(label)
			ready_next = true



func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	ready_next = true
	pass # Replace with function body.
