extends CharacterBody2D

@export var speed: int = 50
@onready var level: Node2D = get_parent()

signal shoot_laser(pos)

func _process(_delta):
	var direction: int = int(Input.get_axis("left", "right"))
	
	velocity = Vector2(direction, 0)*speed
	move_and_slide()
	
	if Input.is_action_just_pressed("shoot") and level.lasers_left > 0:
		shoot_laser.emit(global_position)
