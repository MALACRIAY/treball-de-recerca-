extends Control
 
@onready var label = $VBoxContainer/TextureRect/Label

@onready var countdown = $"../countdown/countdown"

@onready var boton_ok := $VBoxContainer/OK
 
var  text : String

var text_num = 0

var solver : float

var red_spd = 40
 
 
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

		text = "Sabias que los discos de hockey no pesan ni 200 gramos, aunque con la velocidad que alcanzan cuando se disparan a portería son muy veloces. "

		text_num += 1

	elif  text_num == 1:

		text = "¿No lo sabias?, como se nota que me gusta mucho el hockey, como habrás comprobado."

		text_num += 1

	elif  text_num == 2:

		text = "Ahora que has escuchado mi dato estas obligado a jugar un partido contra mí, sería un método de pago."

		text_num += 1

	elif text_num == 3:

		text = "El primero en meter "+str((GlobalScript.difficulty)*2)+" goles gana. Buena suerte, amigo, porque contra mí la necesitarás."

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

	if GlobalScript.hockey_won:

		end()

func add_to_hover():
	boton_ok.add_to_group("hover_click")
	boton_ok.pressed.connect(_pressed.bind(boton_ok))
 
func si():
	visible = false
	GlobalScript.points_blue = 0
	GlobalScript.points_red = 0
	boton_ok.disabled = false
	countdown.play("count")

func no():
	get_tree().change_scene_to_file("res://scenes/Levels/Principal.tscn")

func end():
	text = "Molt be, has guanyat!"
	boton_ok.disabled = false
	visible = true
 
func _pressed(object):

	if object == boton_ok:

		_texts()

 
