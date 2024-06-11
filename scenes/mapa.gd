extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _bandera_1():
	get_tree().change_scene_to_file("res://scenes/rio.tscn") # Replace with function body.


func _bandera_1_mouse_entered():
	$"0tnbPu/banderas/bandera1".global_position.y += 5# Replace with function body.


func _bandera_1_mouse_exited():
	$"0tnbPu/banderas/bandera1".global_position.y -= 5 # Replace with function body.
