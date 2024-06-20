extends Node2D
@onready var character = $Main_character
@onready var camera = $Camera2D
var middle = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	for button in $banderas.get_children():
		button.pressed.connect(_on_pressed.bind(button))

func _on_pressed(button):
	if button == $banderas.get_child(0):
		get_tree().change_scene_to_file("res://scenes/Levels/test.tscn")
# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camera.global_position.y = character.global_position.y
	if character.global_position.x < middle:
		camera.global_position.x = move_toward(camera.global_position.x,-500,20)
	else:
		camera.global_position.x = move_toward(camera.global_position.x,500,20)
