extends Control

const SAVE_PATH := "user://savedata.save"
var highscore := 0

func _ready():
	load_highscore()
	
	if Global.score > highscore:
		highscore = Global.score
		save_highscore()
	
	$UILayer/Labels/Label.text = $UILayer/Labels/Label.text + str(highscore)

func load_highscore():
	if FileAccess.file_exists(SAVE_PATH):
		var save_data := FileAccess.open(SAVE_PATH, FileAccess.READ)
		highscore = save_data.get_var()
		save_data.close()

func save_highscore():
	var save_data := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	save_data.store_var(highscore)
	save_data.close()

func _on_restart_btn_pressed():
	Global.reset_values()
	get_tree().change_scene_to_file("res://scenes/levels/level_01.tscn")
