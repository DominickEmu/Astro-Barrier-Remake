extends PathFollow2D

class_name TargetNode

enum TargetState 
{
	ONE_HIT,
	TWO_HIT,
	EXTRA_LIFE,
	DISABLED
}

signal get_life(pos: int)

@export var speed: float = 100
@export var state: TargetState = TargetState.ONE_HIT
@export var direction: int = 1
var width: int
var height: int

func _ready():
	Global.targets += 1
	change_sprite()

func _process(delta):
	if state != TargetState.DISABLED:
		progress += delta*speed*direction

func hit():
	if state == TargetState.ONE_HIT:
		if Global.first_hit:
			Global.first_hit = false
		
		change_state(TargetState.DISABLED)
	
	elif state == TargetState.EXTRA_LIFE:
		if Global.first_hit:
			Global.first_hit = false
			get_life.emit(global_position)
		
		change_state(TargetState.DISABLED)
	
	elif state == TargetState.TWO_HIT:
		if Global.first_hit:
			Global.first_hit = false
		
		change_state(TargetState.ONE_HIT)
		change_sprite()
	

func change_sprite():
	$Sprite2D.frame = state

func change_state(to_state: TargetState):
	state = to_state
	
	Global.score += 10
	if state == TargetState.DISABLED:
		Global.targets -= 1
	
	change_sprite()

func _on_target_body_entered(_path_end):
	direction *= -1
