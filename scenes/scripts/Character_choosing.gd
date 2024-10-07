extends Node2D

@onready var character = $Character
@onready var ok_button = $Tick
@onready var colors_all = $PanelColors/Colors.get_children()
@onready var animations = $AnimationPlayer

var current_picking : int = 0 # 0 = face, 1 = hair , 2 = body

var face_colors_list : Array = [
	Color(1.0, 0.847, 0.741, 1.0),
	Color(0.812, 0.643, 0.533, 1.0),
	Color(0.878, 0.624, 0.482, 1.0),
	Color(0.702, 0.404, 0.267, 1.0),
	Color(0.620, 0.345, 0.227, 1.0),
	Color(0.561, 0.310, 0.200, 1.0),
	Color(0.502, 0.275, 0.180, 1.0),
	Color(0.420, 0.216, 0.133, 1.0),
	Color(0.329, 0.173, 0.114, 1.0)
]
var hair_colors_list : Array = [
	Color(0.180, 0.180, 0.180, 1.0),  # Negre
	Color(0.294, 0.180, 0.090, 1.0),  # Marró fosc
	Color(0.545, 0.369, 0.235, 1.0),  # Marró clar
	Color(0.890, 0.780, 0.478, 1.0),  # Ros
	Color(0.957, 0.918, 0.824, 1.0),  # Ros platí
	Color(0.706, 0.322, 0.227, 1.0),  # Pèl roig
	Color(0.820, 0.208, 0.145, 1.0),  # Vermell vibrant
	Color(0.353, 0.353, 0.353, 1.0),  # Gris fosc
	Color(0.694, 0.694, 0.694, 1.0),  # Gris clar
	Color(0.647, 0.427, 0.749, 1.0),  # Púrpura fantasia
	Color(0.290, 0.565, 0.886, 1.0),  # Blau fantasia
	Color(0.969, 0.553, 0.698, 1.0)   # Rosa fantasia
]
var body_colors_list : Array = [
	Color(0.200, 0.200, 0.200, 1.0),  # Negre intens
	Color(0.584, 0.647, 0.651, 1.0),  # Gris clar brillant
	Color(0.925, 0.941, 0.945, 1.0),  # Blanc brillant
	Color(0.878, 0.804, 0.663, 1.0),  # Beix brillant
	Color(0.690, 0.545, 0.357, 1.0),  # Marró suau
	Color(0.427, 0.518, 0.557, 1.0),  # Blau grisós clar
	Color(0.616, 0.741, 0.373, 1.0),  # Verd oliva clar
	Color(0.643, 0.765, 0.839, 1.0),  # Blau clar brillant
	Color(0.639, 0.773, 0.525, 1.0),  # Verd salvia brillant
	Color(0.969, 0.969, 0.969, 1.0)   # Blanc perlat
]




# Called when the node enters the scene tree for the first time.
func _ready():
	_set_colors_positions()
	_set_colors()
	_add_to_hover()

func _add_to_hover():
	for color in colors_all:
		color.add_to_group("hover_click")
		color.item_rect_changed.connect(self._clicked.bind(colors_all.find(color)))
	ok_button.item_rect_changed.connect(self._ok_button_clicked)
	pass

func _set_colors_positions():
	var x = -1
	var y = -1
	var margin = 39
	for sprite in colors_all:
		sprite.position =Vector2(x * margin, y * margin)
		x += 1
		if x == 2:
			x = -1
			y += 1

func _set_colors():

	for color in colors_all:
		if current_picking == 0: # face
			color.set_modulate(face_colors_list[colors_all.find(color)]) 
		elif current_picking == 1:
			color.set_modulate(hair_colors_list[colors_all.find(color)]) 
		elif current_picking == 2:
			color.set_modulate(body_colors_list[colors_all.find(color)]) 

func _clicked(color_index):
	if current_picking == 0: # face
		character.material.set_shader_parameter("Face_color",face_colors_list[color_index])
	elif current_picking == 1:
		character.material.set_shader_parameter("Hair_color",hair_colors_list[color_index]) 
	elif current_picking == 2:
		character.material.set_shader_parameter("Body_color",body_colors_list[color_index]) 
	pass

func _ok_button_clicked():
	if current_picking <= 1 and not animations.is_playing(): #face or hair
		current_picking += 1
		animations.play("back_and_forth")
		await get_tree().create_timer(.5).timeout
		_set_colors()
	elif current_picking == 2 and not animations.is_playing():
		GlobalScript.character_colors.append_array([character.material.get_shader_parameter("Face_color"),character.material.get_shader_parameter("Hair_color"),character.material.get_shader_parameter("Body_color")])
		get_tree().change_scene_to_file("res://scenes/Levels/Principal.tscn")
	print(GlobalScript.character_colors)
	pass

