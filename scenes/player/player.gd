extends CharacterBody2D

@export var speed: int = 50
@onready var level: Node2D = get_parent()

signal shoot_laser(pos)

func _process(_delta):
	var mouse_position : Vector2 = get_global_mouse_position()
	var direction: int = int(Input.get_axis("left", "right"))
	
	velocity = Vector2(direction, 0)*speed
	move_and_slide()
	
	if Input.is_action_just_pressed("shoot") and level.lasers_left > 0:
		var within_bound : bool = mouse_position.y < 340 and ((Global.is_mobile and mouse_position.y > 240) or not Global.is_mobile)
		if within_bound:
			$ShootPlayer.stop()
			shoot_laser.emit(global_position)
			$ShootPlayer.play()
