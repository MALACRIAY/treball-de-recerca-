extends CharacterBody2D
@onready var animation = $"../AnimationPlayer"
@onready var anim = $AnimatedSprite2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
func _ready():
	_set_colors()
	anim.play("move")
func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if not animation.is_playing():
		velocity = (get_global_mouse_position()-global_position).normalized() * SPEED
		#global_position.x = move_toward(global_position.x,get_global_mouse_position().x,SPEED)
		#global_position.y = move_toward(global_position.y,get_global_mouse_position().y,SPEED)
		if global_position.x < get_global_mouse_position().x:
			anim.flip_h = false
		else:
			anim.flip_h = true
	move_and_slide()

func _set_colors():
	var list = GlobalScript.character_colors
	anim.material.set_shader_parameter("Face_color",list[0])
	anim.material.set_shader_parameter("Hair_color",list[1]) 
	anim.material.set_shader_parameter("Body_color",list[2]) 
