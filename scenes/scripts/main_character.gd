extends CharacterBody2D
@onready var animation = $"../AnimationPlayer"
@onready var anim = $AnimatedSprite2D
@onready var Camera = %Camera
const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var move : bool = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
func _ready():
	_set_colors()
	_set_camera()
	

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	Camera.global_position = global_position
	if move:
		anim.play("move")
		if not animation.is_playing():
			velocity = (get_global_mouse_position()-global_position).normalized() * SPEED
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


func _set_camera():
	Camera.position_smoothing_enabled = false
	Camera.global_position = global_position
	Camera.position_smoothing_enabled = true
	Camera.scale = Vector2(1,1)

func _set_colors():
	var list = GlobalScript.character_colors
	anim.material.set_shader_parameter("Face_color",list[0])
	anim.material.set_shader_parameter("Hair_color",list[1]) 
	anim.material.set_shader_parameter("Body_color",list[2]) 
