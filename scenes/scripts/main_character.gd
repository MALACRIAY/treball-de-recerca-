extends CharacterBody2D

@onready var anim : Object
@onready var Camera = %Camera
@onready var start : Object 

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var move : bool = false
# Get the gravity from the project settings to be synced with RigidBody nodes.

func _ready():
	if GlobalScript.home:
		$AnimatedSprite2D2.visible = false
		anim = $AnimatedSprite2D
	else:
		$AnimatedSprite2D.visible = false
		anim = $AnimatedSprite2D2
	anim.visible = true
	if Camera:
		if start:
			if GlobalScript.level == 4:
				Camera._change_scene("res://scenes/Levels/final.tscn")
			else:
				global_position = start.get_child(GlobalScript.level).global_position
	_set_colors()
	
	

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if move:
		anim.play("move")
		velocity = (Camera.ball.global_position-global_position).normalized() * SPEED
			#global_position.x = move_toward(global_position.x,get_global_mouse_position().x,SPEED)
			#global_position.y = move_toward(global_position.y,get_global_mouse_position().y,SPEED)
		if global_position.x < get_global_mouse_position().x:
			anim.flip_h = false
		else:
			anim.flip_h = true
	else:
		velocity = Vector2(0,0)
		anim.stop()
	
	move_and_slide()

func _set_colors():
	var list = GlobalScript.character_colors
	anim.material.set_shader_parameter("Face_color",list[0])
	anim.material.set_shader_parameter("Hair_color",list[1]) 
	anim.material.set_shader_parameter("Body_color",list[2]) 
