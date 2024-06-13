extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _bandera_1_mouse_entered():
	$"0tnbPu/banderas".get_child(GlobalScript.level).global_position.y += 20# Replace with function body.


func _bandera_1_mouse_exited():
	$"0tnbPu/banderas".get_child(GlobalScript.level).global_position.y -= 20 # Replace with function body.


func _on_bandera_1():
	#$"0tnbPu/banderas".get_child(GlobalScript.level).icon.resource_path = "res://images/propias/bandera_verde.png"
	$"0tnbPu/banderas/Bandera1".icon.resource_path = "res://images/propias/bandera_verde.png"	
	GlobalScript.level += 1
	get_child_count()
	
	#get_tree().change_scene_to_file("res://scenes/rio.tscn") # Replace with function body.
