extends Control

@onready var label = $VBoxContainer/TextureRect/Label
@onready var countdown = $"../countdown/AnimatedSprite2D"
@onready var boton_si := $VBoxContainer/si_o_no/si
@onready var boton_no := $VBoxContainer/si_o_no/no

var  text : String
var first_time = true
var solver : float
var red_spd = 40

func _ready():
	visible = true
	boton_si.disabled = false
	boton_no.disabled = false
	
	if first_time:
		text = "Hola em dic Joan,
		 et proposo una partida d'Hoquei de gel.
		Acceptes? "
		first_time = false
	else:
		text = "Veig que t'ho has repensat, encara pots jugar si vols
																														
		Acceptes? "
	add_to_hover()

func _process(delta):
	label.text = text
	solver += delta * red_spd
	label.visible_characters = solver
	if GlobalScript.guanyat:
		end()
func add_to_hover():
	boton_si.add_to_group("hover_click")
	boton_si.pressed.connect(_pressed.bind(boton_si))
	boton_no.add_to_group("hover_click")
	boton_no.pressed.connect(_pressed.bind(boton_no))

func si():
	visible = false
	GlobalScript.points_blue = 0
	GlobalScript.points_red = 0
	boton_si.disabled = false
	boton_no.disabled = false
	countdown.play("count")

func no():
	get_tree().change_scene_to_file("res://scenes/Levels/Principal.tscn")

func end():
	text = "Molt be, has guanyat!
																													
	Vols tornar a jugar?"
	boton_si.disabled = false
	boton_no.disabled = false
	visible = true

func _pressed(object):
	if object == boton_si:
		si()
	elif object == boton_no:
		no()
