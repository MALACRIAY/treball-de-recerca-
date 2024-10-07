extends Control
 
@onready var label = $VBoxContainer/TextureRect/Label
@onready var countdown = $"../countdown/countdown"
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
		text = "Estoy desesperada, se me han esparcido todas mis flores, si no las recupero pronto no voy a llegar a dárselas a mi madre. "
		text_num += 1
	elif  text_num == 1:
		text = "¿Crees que serias capaz de ayudarme? Solo me faltan "+str($"..".flowers_max)+" flores"
		text_num += 1
	elif  text_num == 2:
		text = "Muchas gracias. Para tu información hay 2 tipos de flores, las rojas y las violetas, sepáralas y déjalas cada una en su cesta por favor. "
		text_num += 1
	elif text_num == 3:
		text_num += 1
		si()
	elif text_num == 4:
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
