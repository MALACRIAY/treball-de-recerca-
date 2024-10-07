extends Control
 
@onready var label = $VBoxContainer/TextureRect/Label
@onready var countdown = $"../countdown"
@onready var boton_ok := $VBoxContainer/OK
 
 
var  text : String
var text_num = 0
var solver : float
var red_spd = 40
var won : bool
 
func _ready():
	_restart()
	_config_butons()
	_texts()
	add_to_hover()
 
func _config_butons():
	boton_ok.disabled = false
	boton_ok.visible = true

func _restart(): 
	$"../Camera2D".global_position = Vector2(0,0)
	$"../Camera2D".zoom = Vector2(1,1)
	visible = true
	
func _texts():
	solver = 0
	if text_num == 0:
		text = "Disculpa, ¿serias tan amable de ayudarme?, quiero entregarle esta carta a mi amiga, el problema es que ella esta en el parque con el skate."
		text_num += 1
	elif  text_num == 1:
		text = "El problema es que de camino me he caído de mi skate y me he hecho daño."
		text_num += 1
	elif  text_num == 2:
		text = "Antes de que digas que esta muy lejos puedo dejarte mi skate para que llegues más rápido."
		text_num += 1
	elif text_num == 3:
		text = "Pero cuidado con los obstáculos que hay de camino, no te vaya a pasar lo mismo que a mí. Muchas gracias"
		text_num += 1
	elif text_num == 4:
		text = "Muchas gracias"
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
	$"../Camera2D".zoom = Vector2(1.7,1.7)
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
