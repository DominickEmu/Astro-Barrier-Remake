extends Node2D

class_name LevelScene

@onready var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
@onready var life_effect_scene: PackedScene = preload("res://scenes/effects/1up_effect.tscn")
@onready var laser_icon_scene: PackedScene = preload("res://scenes/ui/laser_icon.tscn")

@export_range(0,10) var lasers_left: int

func _ready():
	Global.connect("change_lives_ui", change_lives)
	Global.connect("change_score_ui", change_score)
	Global.connect("display_loading", display_loading)
	
	change_lives()
	change_score()
	
	$Player.connect("shoot_laser", _on_player_shoot)
	$UILayer/Labels/Level.text = "L%02d" % name.to_int()
	
	for laser in lasers_left:
		var laser_icon = laser_icon_scene.instantiate()
		$UILayer/BulletContainer.add_child(laser_icon)
	
	var paths = $PathsTargets.get_children()
	for path in paths:
		var target: TargetNode
		for node in path.get_children():
			if node.is_in_group("Target"):
				target = node
				break
		
		if target.state == target.TargetState.EXTRA_LIFE:
			target.connect("get_life", _on_extra_life)

func _on_player_shoot(pos):
	var laser = laser_scene.instantiate() as Node2D
	
	laser.global_position = pos
	$Projectiles.add_child(laser)
	
	lasers_left -= 1
	if lasers_left < 0:
		pass
	else:
		$UILayer/BulletContainer.get_child(0).queue_free()

func _on_extra_life(pos):
	Global.lives += 1
	
	var life_effect: Node2D = life_effect_scene.instantiate() as Node2D
	life_effect.global_position = pos+Vector2.UP*16
	$Effects.add_child(life_effect)

func change_lives():
	$UILayer/Labels/Lives.text = "Lives: "+str(Global.lives)

func change_score():
	$UILayer/Labels/Score.text = "%05d" % Global.score

func display_loading():
	$UILayer/LoadingPanel/Score.text = str(Global.score)
	$UILayer/LoadingPanel.visible = true
