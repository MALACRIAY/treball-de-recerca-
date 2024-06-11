extends CharacterBody2D


const SPEED = 100.0
const VELOCITY = 3

# Get the gravity from the project settings to be synced with RigidBody nodes.


func _physics_process(delta):

	#rotation
	var mouse = get_global_mouse_position()
	global_position.x = move_toward(global_position.x,mouse.x,VELOCITY)
	velocity.y = SPEED
	move_and_slide()
