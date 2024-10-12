extends Node2D
 
@onready var button_ok : Object = $Foreground/OK
@onready var text_label : Object = $Foreground/squares/Label
@onready var square_anim : Object = $Foreground/squares
@onready var face_anim : Object = $Foreground/faces


var texts_level_1 : Array = [
	"¿Quién vive en la piña debajo del mar? ",
	"Que no sabes como continua? No hay problema grumete. Ahora mismo estaba a punto de partir a surcar los mares con mi barco, ¿quieres acompañarme?",
	"Genial, pues ya estas subiendo grumete, si quieres te puedo dejar a cargo del timón."
] 

var current_text = 0

func _ready():
	button_ok.add_to_group("hover_click")
	button_ok.item_rect_changed.connect(self._clicked)
	pass
func _config_butons():
	pass
 
func _set_texts():
	current_text += 1
	pass
 
func _process(delta):
	var current_level_texts = GlobalScript.texts_all[GlobalScript.level]
	if current_text < len(current_level_texts):
		text_label.text = current_level_texts[current_text]
	else:
		visible = false

func _clicked():
	_set_texts()
	pass
	
