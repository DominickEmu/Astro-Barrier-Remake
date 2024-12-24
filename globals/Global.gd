extends Node

var is_mobile : bool

var targets : int = 0:
	set(value):
		targets = value
		if targets <= 0 and not restarting:
			new_level()
		elif check_loss():
			restart(1)

var lives: int = 2:
	set(value):
		lives = value
		change_lives_ui.emit()

var score: int = 0:
	set(value):
		score = value
		change_score_ui.emit()
var start_score: int = score

@onready var level: int =  get_tree().get_current_scene().name.to_int()

var first_hit: bool = true
var restarting: bool = false

signal change_lives_ui
signal change_score_ui
signal display_loading
signal display_restarting

func _ready():
	match OS.get_name():
		"Web":
			is_mobile = JavaScriptBridge.eval("/windows phone/i.test(navigator.userAgent || navigator.vendor || window.opera) || /android/i.test(navigator.userAgent || navigator.vendor || window.opera) || (/iPad|iPhone|iPod/.test(navigator.userAgent || navigator.vendor || window.opera) && !window.MSStream)", true)
		"Android", "iOS":
			is_mobile = true
		_:
			is_mobile = false

func new_level():
	score += get_tree().get_current_scene().lasers_left*10
	
	display_loading.emit()
	
	get_tree().paused = true
	await get_tree().create_timer(2).timeout
	get_tree().paused = false
	
	level = get_tree().get_current_scene().name.to_int() + 1
	if ResourceLoader.exists("res://scenes/levels/level_%02d.tscn" % (level)):
		get_tree().call_deferred("change_scene_to_file", "res://scenes/levels/level_%02d.tscn" % (level))
	else:
		get_tree().call_deferred("change_scene_to_file", "res://scenes/ui/win.tscn")
	
	first_hit = true
	start_score = score

func restart(lives_lost : int):
	restarting = true
	display_restarting.emit()
	
	get_tree().paused = true
	await get_tree().create_timer(1.5).timeout
	get_tree().paused = false
	
	first_hit = true
	score = start_score
	lives -= lives_lost
	targets = 0
	
	get_tree().call_deferred("reload_current_scene")
	restarting = false

func check_loss() -> bool:
	var level_scene := get_tree().get_current_scene() as LevelScene
	return targets > 0 and level_scene.lasers_left <= 0 and level_scene.get_node("Projectiles").get_child_count() == 0

func reset_values():
	lives = 2
	score = 0
