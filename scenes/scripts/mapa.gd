extends Node2D

@onready var character = $Main_character
@onready var camera = %Camera
@onready var zonas_3i4 = $Zonas_3i4
@onready var animations = $AnimationPlayer
@onready var dialogo = $Dialogo

# Called when the node enters the scene tree for the first time.
func _ready():
	_set_flags()
	camera.clock.visible = false
	await self.get_tree().create_timer(2).timeout
	character.move = true
	

func _set_flags():
	for area in $banderas.get_children():
		area.body_entered.connect(_body_entered.bind(area))

func _body_entered(body,area):
	if body == character:
		dialogo.visible = true
		dialogo.global_position = camera.global_position
		dialogo.flag_num = area.get_index()
		character.move = false
		camera.clock.visible = true

func _process(delta):
	pass

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
