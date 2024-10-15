extends Node2D
 
@onready var difficulties : Array = $Foreground/Difficulties.get_children()
@onready var start : Object = $Foreground/Start
@onready var clicker : Object  = %Camera.get_child(0)
@onready var tutorial_lights : Array = $Tutorial.get_children()
@onready var diff_slider : Object = $Foreground/Difficulties/Loading_diff
var first_time : bool = false
 


func _ready():
	_tutorial()
	_set_hover_click()
	_starting_positions()
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
		%Camera._change_scene("res://scenes/Levels/Character_choosing.tscn")
	else:
		%Camera.global_position.x += 1200
		first_time = true
		_tutorial()

func _tutorial():
	if first_time:
		await self.get_tree().create_timer(5).timeout
		tutorial_lights[2].visible = true
	await self.get_tree().create_timer(5).timeout
	tutorial_lights[0].visible = true
	await self.get_tree().create_timer(5).timeout
	tutorial_lights[1].visible = true

func _starting_positions():
	%Camera.global_position = Vector2(576,325)
	pass
