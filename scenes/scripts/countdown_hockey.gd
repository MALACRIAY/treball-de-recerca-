extends Node2D
@onready var ch_1 = $"../Character_1"
@onready var stop_2 = $"../Character_2"
var skip : bool
var valor = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default") 
	
func _process(delta):
	if $AnimatedSprite2D.is_playing():
		$Goals_blue.frame = GlobalScript.points_blue
		$Goals_red.frame = GlobalScript.points_red
	else:
		ch_1.start = true
		$"../Character_2/AnimationPlayer1".play("dif_1")
	if skip:
		valor -= delta
		$TextureProgressBar.value = valor
		print($TextureProgressBar.value)
		if $TextureProgressBar.value == 0:
			get_tree().change_scene_to_file("res://scenes/Levels/Principal.tscn")
	else:
		$TextureProgressBar.value = $TextureProgressBar.max_value
		
func _on_texture_progress_bar_mouse_entered():
	skip = true

func _on_texture_progress_bar_mouse_exited():
	skip = false # Replace with function body.
