extends Node2D
var character : int
@onready var timer = $Timer
@onready var charging = $charging
var wait_time = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = wait_time
	for button in $Node2D.get_children():
		button.mouse_entered.connect(_mouse_entered.bind(button))
		button.mouse_exited.connect(_mouse_exited.bind(button))
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer.time_left
	

func _mouse_entered(button):
	timer.start()

func _mouse_exited(button):
	timer.stop()


func _on_timeout():
	GlobalScript.character_num = character
	get_tree().change_scene_to_file("res://scenes/Levels/Principal.tscn")
