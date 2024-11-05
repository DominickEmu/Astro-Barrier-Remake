extends Node

var targets : int = 0:
	set(value):
		targets = value
		if targets <= 0:
			new_level()

var lives: int = 2:
	set(value):
		lives = value
		change_lives_ui.emit()

var score: int = 0:
	set(value):
		score = value
		change_score_ui.emit()

@onready var level: int = get_tree().get_current_scene().name.to_int()

var first_hit: bool = true

#var starting_lasers: Array[int] = [4,7,4,8]

signal change_lives_ui
signal change_score_ui
signal display_loading

func new_level():
	first_hit = true
	score += get_tree().get_current_scene().lasers_left*10
	
	display_loading.emit()
	
	get_tree().paused = true
	await get_tree().create_timer(2).timeout
	get_tree().paused = false
	
	level = get_tree().get_current_scene().name.to_int() + 1
	if ResourceLoader.exists("res://scenes/levels/level_%02d.tscn" % (level)):
		get_tree().call_deferred("change_scene_to_file", "res://scenes/levels/level_%02d.tscn" % (level))
