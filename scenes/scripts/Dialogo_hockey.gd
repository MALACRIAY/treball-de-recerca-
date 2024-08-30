extends Control
@onready var timer = $Timer
@onready var botones = $VBoxContainer/si_o_no
@onready var label = $Label
@onready var animacion = $AnimatedSprite2D
@onready var countdown = $"../countdown/AnimatedSprite2D"
var  text : String
var first_time = true
var conclusion 
var solver : float
var red_spd = 40
func _ready():
	visible = true
	for boton in botones.get_children():
		boton.disabled = false
	if first_time:
		text = "Hola em dic Joan i et proposo una partida d'Hoquei de gel.
																														
		Acceptes? "
	else:
		text = "Veig que t'ho has repensat, encara pots jugar si vols
																														
		Acceptes? "


func _process(delta):
	label.text = text
	solver += delta * red_spd
	label.visible_characters = solver
	if GlobalScript.guanyat:
		end()

func si():
	visible = false
	GlobalScript.points_blue = 0
	GlobalScript.points_red = 0
	for boton in botones.get_children():
		boton.disabled = true
	countdown.play("count")

func no():
	first_time = false
	get_tree().change_scene_to_file("res://scenes/Levels/Principal.tscn")

func end():
	text = "Molt be, has guanyat!
																													
	Vols tornar a jugar?"
	for boton in botones.get_children():
		boton.disabled = false
	visible = true

func _on_si_mouse_entered():
	conclusion = true
	animacion.play("chrg")
	timer.start() # Replace with function body.

func _on_si_mouse_exited():
	animacion.stop()
	timer.stop() # Replace with function body.

func _on_no_mouse_entered():
	conclusion = false
	animacion.play("chrg")
	timer.start() # Replace with function body.

func _on_no_mouse_exited():
	animacion.stop()
	timer.stop() # Replace with function body.

func _on_timer_timeout():
	if conclusion:
		si()
	else:
		no()# Replace with function body.

