extends Area2D

var active : bool = false 

signal deactivate_blocks

func hit():
	if not active:
		active = true
		
		Global.score += 5
		
		deactivate_blocks.emit()
		$Sprite2D.frame = 1
