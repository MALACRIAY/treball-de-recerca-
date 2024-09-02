extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_hover()
	
func add_to_hover():
	var grid = $Control/GridContainer
	for object in grid.get_children():
		if object is TextureButton:
			object.add_to_group("hover_click")
			object.pressed.connect(_pressed.bind(object))

func _pressed(object):
	GlobalScript.character_num = str(object.name)
	get_tree().change_scene_to_file("res://scenes/Levels/Principal.tscn")
