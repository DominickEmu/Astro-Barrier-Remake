extends Node2D

func _ready():
	var final_y = global_position.y - 16
	var tween = create_tween()
	tween.set_parallel(true)
	
	tween.tween_property(self, "modulate:a", 0, .4).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
	tween.tween_property(self, "global_position:y", final_y, .4).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
	
