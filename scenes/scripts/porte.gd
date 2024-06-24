extends Node2D
var goal : bool
var initial_time = .5
var time = .5
var porte 
# Called when the node enters the scene tree for the first time.
func _ready():
	for area in get_children():
		area.body_entered.connect(_body_entered.bind(area))

func _body_entered(body,area):
	print("a")
	if body == $"../Disco":
		goal = true
		porte = area
		print("b")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if goal == true:
		time -= delta
	if time <= 0:
		if porte == $porte_1:
			GlobalScript.points_blue += 1
		elif porte==$"porte_2":
			GlobalScript.points_red += 1
		time = initial_time
		goal = false
		get_tree().reload_current_scene()

