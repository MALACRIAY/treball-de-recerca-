extends Node2D

@onready var ball = $Ball
@onready var keeper = $Keeper
@onready var goalie = $Goal
@onready var animation = $Animation

var in_keeper : bool
var in_goal : bool
var result : int
# Called when the node enters the scene tree for the first time.
func _ready():
	for body in get_children():
		if body is Area2D:
			body.body_entered.connect(_body_entered.bind(body))
			body.body_exited.connect(_body_exited.bind(body))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_ball_shot():
	check_goal() # Replace with function body.

func check_goal():
	if in_goal and not in_keeper:
		result = 1
		animation.play("end")
		print("goal")
	elif in_keeper:
		result = 0
		print("parada")
	elif not in_goal:
		result = 0
		print("out")

func _body_entered(body,area):
	if body == ball:
		if area == keeper:
			print("in_keeper")
			in_keeper = true
		if area == goalie:
			print("in_goal")
			in_goal = true
func _body_exited(body,area):
	if body == ball:
		if area == keeper:
			print("out_keeper")
			in_keeper = false
		elif area == goalie:
			print("out_goal")
			in_goal = false


func _on_animation_finished():
	ball.start = true
