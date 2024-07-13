extends Node2D
var character : int
@onready var timer = $Timer
@onready var charging = $charging
var wait_time = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = wait_time
	for texture in $Textures.get_children():
		var image = $pERSONAJES.get_child(texture.get_index())
		texture.global_position = image.global_position + Vector2(-40, -60)
		texture.mouse_entered.connect(_mouse_entered.bind(texture))
		texture.mouse_exited.connect(_mouse_exited.bind(texture))
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimatedSprite2D.frame = int(timer.time_left)

	

func _mouse_entered(texture):
	print(texture.get_index())
	timer.start()

func _mouse_exited(texture):
	timer.stop()


func _on_timeout():
	GlobalScript.character_num = character
	get_tree().change_scene_to_file("res://scenes/Levels/Principal.tscn")
