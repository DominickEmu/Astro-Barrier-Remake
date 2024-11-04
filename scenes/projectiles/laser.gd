extends Area2D

@export var speed = 200
@export var direction = Vector2.UP

func _process(delta):
	global_position += speed*delta*direction 


func _on_body_entered(body):
	queue_free()

func _on_area_entered(area):
	if area.get_parent().is_in_group("Target"):
		area.get_parent().hit()
	elif area.is_in_group("Switch"):
		print(area)
		area.hit()
	
	queue_free()
