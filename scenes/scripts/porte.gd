extends Node2D
var goal : bool
var initial_time = .5
var time = .5
var porte
var disco
# Called when the node enters the scene tree for the first time.
func _ready():
	for area in get_children():
		area.body_entered.connect(_body_entered.bind(area))

func _body_entered(body,area):
	print("a")
	if body == $"../Disco":
		disco = $"../Disco"
		print(disco.global_position)
		print("Porte: "+str(porte))
		goal = true
		porte = area
		print("b")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalScript.points_blue >= 3:
		get_tree().change_scene_to_file("res://scenes/Levels/Principal.tscn")
		GlobalScript.level+=1
	if goal == true:
		disco.global_position.x = move_toward(disco.global_position.x,porte.global_position.x,10)
		time -= delta
	if time <= 0:
		if porte == $porte_1:
			GlobalScript.points_red += 1
		elif porte==$"porte_2":
			GlobalScript.points_blue += 1
		
		goal = false 
		time = initial_time
		get_tree().reload_current_scene()
