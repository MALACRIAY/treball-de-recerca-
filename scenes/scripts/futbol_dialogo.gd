extends Control
 
@onready var label = $VBoxContainer/TextureRect/Label
@onready var countdown = $"../AnimatedSprite2D"
@onready var boton_ok := $VBoxContainer/OK
 
 
var  text : String
var text_num = 0
var solver : float
var red_spd = 40
var won : bool
 
func _ready():
	visible = true
	_config_butons()
	_texts()
	add_to_hover()
 
func _config_butons():
	boton_ok.disabled = false
	boton_ok.visible = true
 
func _texts():
	solver = 0
	if text_num == 0:
		text = "Hola, llevo rato buscando a alguien para que juegue conmigo a futbol, que te apetece si jugamos un rato."
		text_num += 1
	elif  text_num == 1:
		text = " Aunque siendo solo 2 no podremos jugar un partido. Que te parece si chutamos unos penales. "
		text_num += 1
	elif  text_num == 2:
		text = "Por si no lo sabes un penalti es cuando al jugador le hacen una falta en el área, y para compensar, el jugador puede chutar desde el punto que hay en el área. "
		text_num += 1
	elif text_num == 3:
		text = "Es el jugador contra el portero. Pero basta ya de cháchara, si me marcas 5 goles tendrás premio. Buena suerte!!"
		text_num += 1
	elif text_num == 4:
		text_num += 1
		si()
	elif text_num == 5:
		get_tree().change_scene_to_file("res://scenes/Levels/Principal.tscn")
 
func _process(delta):
	label.text = text
	solver += delta * red_spd
	label.visible_characters = solver
	if won:
		end()
func add_to_hover():
	boton_ok.add_to_group("hover_click")
	boton_ok.pressed.connect(_pressed.bind(boton_ok))
 	
func si():
	visible = false
	boton_ok.disabled = false
	countdown.play("count")
	$"../Camera2D".global_position = countdown.global_position

func no():
	get_tree().change_scene_to_file("res://scenes/Levels/Principal.tscn")
 
func end():
	text = "Molt be, has guanyat!"
	boton_ok.disabled = false
	visible = true
 
func _pressed(object):
	if object == boton_ok:
		_texts()
