extends Node2D
@onready var character = $Main_character
@onready var camera = $Camera2D
var middle = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	for area in $banderas.get_children():
		area.body_entered.connect(_body_entered.bind(area))
	for area in $banderas.get_children():
		if area.get_index() <= GlobalScript.level:
			area.get_child(0)
func _body_entered(body,area):
	print("res://scenes/Levels/Level_"+str(GlobalScript.level)+".tscn")
	get_tree().change_scene_to_file("res://scenes/Levels/Level_"+str(GlobalScript.level)+".tscn")
	#if area == $banderas.get_child(0):
	#	get_tree().change_scene_to_file("res://scenes/Levels/Level_0.tscn")
# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camera.global_position.y = character.global_position.y
	if character.global_position.x < middle:
		camera.global_position.x = move_toward(camera.global_position.x,-500,20)
	else:
		camera.global_position.x = move_toward(camera.global_position.x,500,20)
