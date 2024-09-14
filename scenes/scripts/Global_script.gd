extends Node
#mapa_global
var level = 0
var difficulty = 1
#personatje
var character_num = 0
var current_level : String
#hockey
var points_blue :int
var points_red : int
var hockey_won : bool

func _process(delta):
	
	hockey()
#Hockey_level
func hockey():
	var points_blue :int
	var points_red : int
	var hockey_won = false
	if points_blue >= 3:
		hockey_won = true
	else:
		hockey_won = false

func _input(event):
	if OS.is_debug_build():
		if Input.is_action_just_pressed("p"):
			get_tree().change_scene_to_file("res://scenes/Levels/Principal.tscn")
		if Input.is_action_just_pressed("0"):
			get_tree().change_scene_to_file("res://scenes/Levels/Level_0.tscn")
		if Input.is_action_just_pressed("1"):
			get_tree().change_scene_to_file("res://scenes/Levels/Level_1.tscn")
		if Input.is_action_just_pressed("2"):
			get_tree().change_scene_to_file("res://scenes/Levels/Level_2.tscn")
		if Input.is_action_just_pressed("3"):
			get_tree().change_scene_to_file("res://scenes/Levels/Level_3.tscn")
		if Input.is_action_just_pressed("4"):
			get_tree().change_scene_to_file("res://scenes/Levels/Level_4.tscn")
		if Input.is_action_just_pressed("5"):
			get_tree().change_scene_to_file("res://scenes/Levels/Level_5.tscn")
		if Input.is_action_just_pressed("r"):
			get_tree().reload_current_scene()
			
			
