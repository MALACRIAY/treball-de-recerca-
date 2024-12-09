extends Node2D

@onready var character = $Main_character
@onready var camera = %Camera
@onready var animations = $AnimationPlayer
@onready var dialogo = %Dialogo

# Called when the node enters the scene tree for the first time.
func _ready():
	_set_flags()
	if GlobalScript.level== 0:
		$Label.visible = true
	else:
		$Label.visible = false
	dialogo.visible = false
	camera.clock.visible = false
	character.start = $starting_points
	await self.get_tree().create_timer(2).timeout
	character.move = true
	
func _set_flags():
	for area in $banderas.get_children():
		if area.get_index() < GlobalScript.level:
			area.get_child(2).visible = true
			area.get_child(0).disabled = true
		elif area.get_index() == GlobalScript.level:
			area.get_child(0).disabled = false
		elif area.get_index() > GlobalScript.level:
			area.get_child(2).visible = false
			area.get_child(0).disabled = true
		area.body_entered.connect(_body_entered.bind(area))


func _body_entered(body,area):
	if body == character:
		dialogo.flag_num = area.get_index()
		dialogo._open()
		character.move = false
		camera.clock.visible = true

