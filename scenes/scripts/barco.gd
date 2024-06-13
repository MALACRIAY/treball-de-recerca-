extends CharacterBody2D


const SPEED = 1000.0
const VELOCITY = 30
var entered = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var i = 0

func _physics_process(delta):

	#rotation
	if not entered:
		var mouse = get_global_mouse_position()
		global_position.x = move_toward(global_position.x,mouse.x,VELOCITY)
		velocity.y = SPEED
	move_and_slide()
