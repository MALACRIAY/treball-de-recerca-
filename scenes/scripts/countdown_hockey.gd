extends Node2D

func _ready():
	$countdown.play("count")
	
func _process(delta):
	$Goals_blue.frame = GlobalScript.points_blue
	$Goals_red.frame = GlobalScript.points_red
	pass
