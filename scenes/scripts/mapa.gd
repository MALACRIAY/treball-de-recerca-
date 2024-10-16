extends Node2D

@onready var character = $Main_character
@onready var camera = %Camera
@onready var animations = $AnimationPlayer
@onready var dialogo = %Dialogo

# Called when the node enters the scene tree for the first time.
func _ready():
	_set_flags()
	dialogo.visible = false
	camera.clock.visible = false
	await self.get_tree().create_timer(2).timeout
	character.move = true
	if GlobalScript.level == 1:
		$banderas/Area2D2.get_child(1).disabled = false
		$banderas/Area2D.get_child(1).disabled = true
	if GlobalScript.level == 3:
		$banderas/Area2D4.get_child(1).disabled = false
		$banderas/Area2D3.get_child(1).disabled = true
func _set_flags():
	for area in $banderas.get_children():
		area.body_entered.connect(_body_entered.bind(area))

func _body_entered(body,area):
	if body == character:
		dialogo.visible = true
		dialogo.flag_num = area.get_index()
		character.move = false
		camera.clock.visible = true

func _process(delta):
	pass

func _on_zona_4_body_entered(body):
	if body == character:
		if not animations.is_playing():
			animations.play_backwards("bridge")
