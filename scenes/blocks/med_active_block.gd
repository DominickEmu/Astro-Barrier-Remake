extends StaticBody2D

@onready var switch : Area2D = get_node("/root/Level%02d/Misc" % Global.level).get_child(0) as Area2D

func _ready():
	switch.connect("deactivate_blocks", on_switch_hit)

func on_switch_hit():
	$AnimationPlayer.play("deactivate")
