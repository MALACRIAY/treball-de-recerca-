extends Node2D
 
@onready var button_ok : Object = $Foreground/OK
@onready var text_label : Object = $Foreground/squares/Label
@onready var square_anim : Object = $Foreground/squares
@onready var face_anim : Object = $Foreground/faces

var current_text = 0
var text_letters = 0
var red_speed = 10 * GlobalScript.difficulty
var flag_num 

func _ready():
	_config_images()
	button_ok.add_to_group("hover_click")
	button_ok.item_rect_changed.connect(self._clicked)
	pass

func _config_images():
	square_anim.frame = randi_range(0,3)
	face_anim.frame = randi_range(0,3)

func _set_texts():
	current_text += 1
	text_letters = 0
	pass
 
func _process(delta):
	var current_level_texts = GlobalScript.texts_all[GlobalScript.level]
	if current_text < len(current_level_texts):
		text_label.text = current_level_texts[current_text]
		text_label.visible_characters = text_letters
		text_letters += delta * red_speed
	else:
		%Camera._change_scene("res://scenes/Levels/Level_"+str(flag_num)+".tscn")

func _clicked():
	_set_texts()
	
