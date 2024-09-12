extends Node2D
@onready var character = $Main_character
@onready var camera = $Camera2D
@onready var zonas_3i4 = $Zonas_3i4
@onready var animations = $AnimationPlayer
var middle = 0
var zone_1 = Vector2(1,1000)
var zone_m1 = Vector2(-1000,0)
var zone_m2 = Vector2(-2000,-1001)
# Called when the node enters the scene tree for the first time.
func _ready():
	for area in $banderas.get_children():
		area.body_entered.connect(_body_entered.bind(area))
func _body_entered(body,area):
	if body == $Main_character:
		get_tree().change_scene_to_file("res://scenes/Levels/Level_"+str(area.get_index())+".tscn")

func _process(delta):
	camera.global_position.y = character.global_position.y
	camera.global_position.x = 500 * zona_character(character)
func zona_character(person):
	var pos = person.global_position
	return int(pos.x/500)

func _on_zonas_3_body_entered(body):
	if body == character and GlobalScript.level >= 2:
		if zonas_3i4.get_children().size() > 2:
			zonas_3i4.get_child(2).queue_free()
		if not animations.is_playing():
			animations.play("bridge")

func _on_zona_4_body_entered(body):
	if body == character:
		if not animations.is_playing():
			animations.play_backwards("bridge")
