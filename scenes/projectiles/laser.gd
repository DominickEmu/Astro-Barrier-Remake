extends Area2D

@export var speed = 200
@export var direction = Vector2.UP

@onready var level = get_tree().current_scene as LevelScene

func _process(delta):
	global_position += speed*delta*direction

func _on_body_entered(body):
	check_loss()
	queue_free()

func _on_area_entered(area):
	if area.get_parent().is_in_group("Target"):
		area.get_parent().hit()
	elif area.is_in_group("Switch"):
		area.hit()
	
	self.call_deferred("check_loss")
	
	queue_free()

func check_loss():
	if level.lasers_left <= 0 and get_parent().get_children().size() == 1:
		if Global.targets > 0:
			Global.restart(1)
