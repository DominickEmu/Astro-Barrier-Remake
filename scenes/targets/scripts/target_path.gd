extends Path2D

@onready var start: int = 0
@onready var end: float = curve.get_baked_length()

func _ready():
	$Line2D.points = curve.get_baked_points()
	$EndPoint2.progress = start
	$EndPoint.progress = end
