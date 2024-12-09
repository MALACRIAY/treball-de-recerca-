extends Node2D

@onready var timer = $"../Timer_goal"
@onready var character = $"../Character_1"
@onready var Camera = %Camera

var goal : bool
var disco : Object
var porte : Object

func _ready():
	for area in get_children():
		area.body_entered.connect(_body_entered.bind(area))

func _body_entered(body,area):
	if body == %Disco_hockey:
		disco = body
		porte = area
		goal = true
		check_goal(area,body)

func check_goal(_porte,_disco):
	if goal == true:
		timer.start()
		if porte == $porte_1:
			GlobalScript.points_red += 1
		elif porte==$"porte_2":
			GlobalScript.points_blue += 1
		if GlobalScript.points_blue >= GlobalScript.difficulty * 2:
			push_error("won")
			GlobalScript.level += 1
			GlobalScript.just_won = true
			Camera._change_scene("res://scenes/Levels/Principal.tscn")
		
		
func _process(_delta):
	if not timer.is_stopped():
		disco.global_position.x = move_toward(disco.global_position.x,porte.global_position.x,100)
	
func _on_timer_goal_timeout():
	goal = false
	character.restart() # Replace with function body.
