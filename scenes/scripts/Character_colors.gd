extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var list = GlobalScript.character_colors
	material.set_shader_parameter("Face_color",list[0])
	material.set_shader_parameter("Hair_color",list[1]) 
	material.set_shader_parameter("Body_color",list[2]) 
