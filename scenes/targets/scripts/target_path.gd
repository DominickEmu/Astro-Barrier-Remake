extends Path2D

@onready var start: int = 0
@onready var end: float = curve.get_baked_length()
@export var looping: bool = false

func _ready():
	$Line2D.points = curve.get_baked_points()
	$EndPoint2.progress = start
	$EndPoint.progress = end
	
	$EndPoint/Sprite.visible = not looping
	$EndPoint2/Sprite.visible = not looping
	$EndPoint/StaticBody2D/CollisionShape2D.disabled = looping
	$EndPoint2/StaticBody2D/CollisionShape2D.disabled = looping
