extends Area2D

@export var speed = 200
@export var direction = Vector2.UP

func _process(delta):
	global_position += speed*delta*direction 


func _on_body_entered(body):
	print("hit ", body)
	queue_free()

func _on_area_entered(area):
	if area.get_parent().is_in_group("Target"):
		area.get_parent().hit()
	
	queue_free()
