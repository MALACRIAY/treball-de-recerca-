extends Node2D
@onready var label = $Control/Label
@onready var timer_yes = $Timer_yes
@onready var timer_no = $Timer_no
@onready var character = $"../Character_1"
@onready var countdown = $"../countdown/AnimatedSprite2D"
var letters = 0
var reading_speed = 39
# Called when the node enters the scene tree for the first time.
func _ready():
	if GlobalScript.points_blue >= 3: # Replace with function body.
		$Control/Label.text = "EI, ja m'has guanyat vols jugar un altre cop?"
	else:
		$Control/Label.text = "HOLA, SOC EL JOAN I TINC 16 ANYS 
VOLS FER UNA PARTIDA D'HOQUEI?"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	letters += delta * reading_speed
	label.visible_characters = int(letters)

func _on_timer_yes_timeout():
	if GlobalScript.points_blue < 3:
		character.restart()
		queue_free()
	if GlobalScript.points_blue >= 3: # Replace with function body.
		GlobalScript.points_blue = 0
		GlobalScript.points_red = 0
		character.restart()
		queue_free()

func _on_timer_no_timeout():
	get_tree().change_scene_to_file("res://scenes/Levels/Principal.tscn")

func _on_button_yes_mouse_entered():
	timer_yes.start(3) 
	
func _on_button_yes_mouse_exited():
	timer_yes.stop() 


func _on_button_no_mouse_entered():
	timer_no.start(3) 

func _on_button_no_mouse_exited():
	timer_no.stop() 
