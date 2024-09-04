extends CharacterBody2D

signal shot
@onready var image = $Bola
@onready var area = $CollisionShape2D.scale
@onready var particles = $Bola/Node2D

var speed : float
var min_size = Vector2(.6,.6)
var decrease_speed = 5
var start :=  false

func _ready():
	speed = GlobalScript.difficulty + 1
	decrease_speed = (GlobalScript.difficulty +1) *5
	
func _physics_process(delta):
	if start:
		particles.visible = true
		particles.look_at(global_position-velocity)
		velocity = (get_global_mouse_position()-global_position)* 5 / speed
		if image.scale >= min_size:
			image.scale -= Vector2(delta/decrease_speed,delta/decrease_speed)
		else:
			emit_signal("shot")
		move_and_slide()
	else:
		particles.visible = false



func _on_shot():
	start = false # Replace with function body.
