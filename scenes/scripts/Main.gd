extends Node2D
 
@onready var difficulties : Array = $Foreground/Difficulties.get_children()
@onready var start : Object = $Foreground/Start
@onready var clicker : Object  = %Camera.get_child(1)
@onready var diff_slider : Object = $Foreground/Difficulties/Loading_diff
 


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

func _starting_positions():
	%Camera.visible = false
	%Camera.global_position = Vector2(0,-648)
	await self.get_tree().create_timer(3).timeout
	%Camera.visible = true
	%Camera.global_position = Vector2(0,0)

func _tutorial():
	await self.get_tree().create_timer(3).timeout
	$Tutorial/Label2.visible = true
	await self.get_tree().create_timer(2).timeout
	$Tutorial/Label.visible = true
