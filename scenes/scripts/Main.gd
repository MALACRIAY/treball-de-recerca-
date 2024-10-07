extends Node2D
 
@onready var difficulties : Array = $Foreground/Difficulties.get_children()
@onready var start : Object = $Foreground/Start
@onready var clicker : Object  = $ball
@onready var start_light : Object  = $start_light
@onready var clock_light : Object  = $clock_light
@onready var diff_slider : Object = $Foreground/Difficulties/Loading_diff
var first_time : bool = true
 
func _ready():
	_tutorial()
	_set_hover_click()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if clicker.nodes_in:
		if clicker.nodes_in[0].get_parent() in difficulties:
			diff_slider.frame = difficulties.find(clicker.nodes_in[0].get_parent())

 
func _set_hover_click():
	for button in difficulties:
		Signal(button,"_pressed")
		button.add_to_group("hover_click")
		button.item_rect_changed.connect(self._clicked.bind(button))
	start.add_to_group("hover_click")
	start.item_rect_changed.connect(self._clicked.bind(start))

func _clicked(button):
	if button in difficulties:
		GlobalScript.difficulty = difficulties.find(button)
		get_tree().change_scene_to_file("res://scenes/Levels/Character_choosing.tscn")
	else:
		clicker.global_position.x += 1200

func _tutorial():
	await self.get_tree().create_timer(10).timeout
	start_light.visible = true
	await self.get_tree().create_timer(10).timeout
	clock_light.visible = true
