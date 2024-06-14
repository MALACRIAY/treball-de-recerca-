extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	for button in $"0tnbPu/banderas".get_children():
		button.pressed.connect(_on_pressed.bind(button))

func _on_pressed(button):
	if button == $"0tnbPu/banderas".get_child(GlobalScript.level):
		get_tree().change_scene_to_file("res://scenes/rio.tscn")
# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

