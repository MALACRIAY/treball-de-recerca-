extends Node
#mapa_global
var level = 0
var difficulty := 2
#personatje
var character_colors = [
	Color(0.706, 0.322, 0.227, 1.0),  # Face
	Color(0.878, 0.804, 0.663, 1.0),  # Hair
	Color(0.545, 0.369, 0.235, 1.0),  # Body
]
var current_level : String
#hockey
var points_blue :int
var points_red : int
var hockey_won : bool
var texts_all : Array = [
	#text_0 : hockey
	["Sabias que los discos de hockey no pesan ni 200 gramos, aunque con la velocidad que alcanzan cuando se disparan a portería son muy veloces. ",
	"¿No lo sabias?, como se nota que me gusta mucho el hockey, como habrás comprobado.",
	"Ahora que has escuchado mi dato estas obligado a jugar un partido contra mí, sería un método de pago.",
	 "El primero en meter "+str((difficulty)*2)+" goles gana. Buena suerte, amigo, porque contra mí la necesitarás."],
	#text_1 : Barco
	["¿Quién vive en la piña debajo del mar? ",
	"Que no sabes como continua? No hay problema grumete. Ahora mismo estaba a punto de partir a surcar los mares con mi barco, ¿quieres acompañarme?",
	"Genial, pues ya estas subiendo grumete, si quieres te puedo dejar a cargo del timón."],
	#texts _2 : Flores
	["Estoy desesperada, se me han esparcido todas mis flores, si no las recupero pronto no voy a llegar a dárselas a mi madre. ",
	"¿Crees que serias capaz de ayudarme? Solo me faltan "+str(difficulty * 3)+" flores",
	 "Muchas gracias. Para tu información hay 2 tipos de flores, las rojas y las violetas, sepáralas y déjalas cada una en su cesta por favor. "],
	#texts _3 : Skate
	[ "Disculpa, ¿serias tan amable de ayudarme?, quiero entregarle esta carta a mi amiga, el problema es que ella esta en el parque con el skate.",
	"El problema es que de camino me he caído de mi skate y me he hecho daño.",
	"Antes de que digas que esta muy lejos puedo dejarte mi skate para que llegues más rápido.",
	 "Pero cuidado con los obstáculos que hay de camino, no te vaya a pasar lo mismo que a mí. Muchas gracias"]

] 


	
	

 
func _process(delta):
	hockey()
#Hockey_level
func hockey():
	if points_blue >= difficulty*2:
		hockey_won = true
	else:
		hockey_won = false
 
func _input(event):
	if OS.is_debug_build():
		if Input.is_action_just_pressed("p"):
			get_tree().change_scene_to_file("res://scenes/Levels/Principal.tscn")
		if Input.is_action_just_pressed("0"):
			get_tree().change_scene_to_file("res://scenes/Levels/Level_0.tscn")
		if Input.is_action_just_pressed("1"):
			get_tree().change_scene_to_file("res://scenes/Levels/Level_1.tscn")
		if Input.is_action_just_pressed("2"):
			get_tree().change_scene_to_file("res://scenes/Levels/Level_2.tscn")
		if Input.is_action_just_pressed("3"):
			get_tree().change_scene_to_file("res://scenes/Levels/Level_3.tscn")
		if Input.is_action_just_pressed("4"):
			get_tree().change_scene_to_file("res://scenes/Levels/Level_4.tscn")
		if Input.is_action_just_pressed("5"):
			get_tree().change_scene_to_file("res://scenes/Levels/Level_5.tscn")
		if Input.is_action_just_pressed("r"):
			get_tree().reload_current_scene()
