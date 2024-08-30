extends Node2D
@onready var timer_skip = $"../countdown/Timer_skip"
@onready var timer = $"../Timer_goal"
@onready var character = $"../Character_1"
var goal : bool


func _ready():
	
	for area in get_children():
		area.body_entered.connect(_body_entered.bind(area))

func _body_entered(body,area):
	if body == %Disco_hockey:
		goal = true
		check_goal(area)

func check_goal(porte):
	if goal == true:
		timer.start()
		if porte == $porte_1:
			GlobalScript.points_red += 1
		elif porte==$"porte_2":
			GlobalScript.points_blue += 1

func _process(delta):
	pass
	
func _on_timer_goal_timeout():
	timer.stop()
	goal = false
	character.restart() # Replace with function body.
