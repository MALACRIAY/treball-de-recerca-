extends Node2D

@onready var character_m : Sprite2D = $Character_m
@onready var character_d : Sprite2D = $Character_d


var character : Object
# Called when the node enters the scene tree for the first time.
func _ready():
	if GlobalScript.home:
		character_m.visible = true
		character_d.visible = false
		character = character_m
	else:
		character_d.visible = true
		character_m.visible = false
		character = character_d
	var list = GlobalScript.character_colors
	character.material.set_shader_parameter("Face_color",list[0])
	character.material.set_shader_parameter("Hair_color",list[1]) 
	character.material.set_shader_parameter("Body_color",list[2]) 
