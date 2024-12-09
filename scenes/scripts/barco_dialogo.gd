extends Node2D																																
 
@onready var button_ok : Object = $Foreground/OK
@onready var text_label : Object = $Foreground/squares/Label
@onready var square_anim : Object = $Foreground/squares
@onready var face_anim : Object = $Foreground/faces
@onready var backgrounds : Array = $Background.get_children()

var texts = [
	#Hockey
	"Te reto a una partida de hockey hielo, el primero en meter " + str(GlobalScript.difficulty*2) + " goles gana, preparado?",
	#Barco
	"Buenas grumete, me podrias llevar estas cajas al otro lado del río? Te dejo a cargo del timón.",
	#Flores
	"¿Crees que serias capaz de ayudarme? Se me han caído las flores, y las tengo que separar por colores, solo me faltan " + str(GlobalScript.difficulty * 3),
	#Memory
	"Mira he descubierto un nuevo juego de cartas muy divertido, quieres jugar conmigo?"
]
var current_text = 0
var text_letters = 0
var red_speed = 30 * GlobalScript.difficulty
var flag_num = 0

func _ready():
	button_ok.add_to_group("hover_click")
	button_ok.item_rect_changed.connect(self._clicked)
	text_letters = 0

func _open():
	
	square_anim.frame = flag_num
	face_anim.frame = flag_num
	visible = true


func _process(delta):
	if self.visible:
		
		text_label.text = texts[flag_num]
		text_label.visible_characters = text_letters
		text_letters += delta * red_speed
	

func _clicked():
	%Camera._change_scene("res://scenes/Levels/Level_"+str(flag_num)+".tscn")

	
