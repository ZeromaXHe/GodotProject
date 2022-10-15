extends Node

signal coins_changed

# 暂无 BGM
const BGM_IDX = -1
# 对应正下面 - 音频 中 SFX 的索引（第二个对应 1）
const SFX_IDX = 1
const CONFIG_PATH = "user://settings.cfg"

var bgm_enabled setget set_bgm_enabled, is_bgm_enabled
var sfx_enabled setget set_sfx_enabled, is_sfx_enabled

var coins_collected: int = 0
var coins_pending: int = 0 setget _set_coins_pending
var deaths: int = 0
var started_at: int = OS.get_unix_time()
var completed_at: int = OS.get_unix_time()

onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	load_config()


func get_coins():
	return coins_collected + coins_pending


func _set_coins_pending(value):
	coins_pending = value
	emit_signal("coins_changed")


func back_to_title():
	go_to_world("res://platformer/src/ui/title_screen.tscn")


func start_game():
	coins_collected = 0
	coins_pending = 0
	deaths = 0
	started_at = OS.get_unix_time()
	go_to_world("res://platformer/src/worlds/world01.tscn")


func complete_game():
	completed_at = OS.get_unix_time()
	_animate_transition_to("res://platformer/src/ui/game_complete.tscn")


func reload_world():
	coins_pending = 0
	deaths += 1
	_animate_transition_to(null)


func go_to_world(path):
	coins_collected += coins_pending
	coins_pending = 0
	_animate_transition_to(path)

func _animate_transition_to(path):
	animation_player.play_backwards("FadeIn")
	yield(animation_player, "animation_finished")
	if path:
		get_tree().change_scene(path)
	else:
		get_tree().reload_current_scene()
	animation_player.play("FadeIn")


func is_bgm_enabled():
	return not AudioServer.is_bus_mute(BGM_IDX)


func set_bgm_enabled(value: bool):
	AudioServer.set_bus_mute(BGM_IDX, not value)


func is_sfx_enabled():
	return not AudioServer.is_bus_mute(SFX_IDX)


func set_sfx_enabled(value: bool):
	AudioServer.set_bus_mute(SFX_IDX, not value)


func save_config():
	var file = ConfigFile.new()
	file.set_value("audio", "sfx_enabled", is_sfx_enabled())
	var err = file.save(CONFIG_PATH)
	if err != OK:
		push_error("Failed to save config: %d" % err)


func load_config():
	var file = ConfigFile.new()
	var err = file.load(CONFIG_PATH)
	if err == OK:
		set_sfx_enabled(file.get_value("audio", "sfx_enabled", true))
	else:
		push_warning("Failed to load config: %d" % err)
		set_sfx_enabled(true)
