extends Node2D
@onready var disco = $Disco
@onready var Charact_1 = $Character_1
@onready var Charact_2 = $Character_2
@onready var Goal_1 = $Campo/porte_1
@onready var Goal_2 = $Campo/porte_2
@onready var Tiempo = $countdown


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Charact_1.global_position = Vector2(move_toward(Charact_1.global_position.x,get_global_mouse_position().x,3),move_toward(Charact_1.global_position.y,get_global_mouse_position().y,3))
	


func _physics_process(delta):
	Charact_1.global_position = Vector2(move_toward(Charact_1.global_position.x,get_global_mouse_position().x,3),move_toward(Charact_1.global_position.y,get_global_mouse_position().y,3))
	



func _on_goal_2_entered(body):
	pass # Replace with function body.


func _on_goal_1_body_entered(body):
	pass # Replace with function body.
