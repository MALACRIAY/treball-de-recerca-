extends Control

@onready var difficulties = $HBoxContainer/TextureRect2/VBoxContainer/HBoxContainer.get_children()
@onready var clicker = $Camera2D/Control
@onready var camera = $Camera2D

@onready var secret = $HBoxContainer/TextureRect2/Imp_hard

func _ready():
	clicker.visible = true # Replace with function body.
	for button in difficulties:
		button.add_to_group("hover_click")
		button.pressed.connect(_pressed.bind(button.get_index()))
	secret.add_to_group("hover_click")
	secret.pressed.connect(_pressed.bind(4))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _pressed(difficulty):
	GlobalScript.difficulty = difficulty
	if difficulty > 3:
		secret.z_index = 0
	await self.get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scenes/Levels/Character_choosing.tscn")

func _on_start():
	camera.global_position.x += 1150

