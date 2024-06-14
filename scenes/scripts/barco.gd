extends CharacterBody2D

const initial_accel = 30.0
var acceleration = initial_accel
const SPEED_back = -300.0
const VELOCITY = 10
var difficulty = 1
var max_velocity = 500.0
var entered = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var i = 0

func _physics_process(delta):

	#rotation
	if not entered:
		var mouse = get_global_mouse_position()
		global_position.x = move_toward(global_position.x,mouse.x,VELOCITY)
		velocity.y = (acceleration*difficulty)*delta
		if velocity.y > max_velocity:
			velocity.y = max_velocity
		if $AnimationPlayer.is_playing():
			acceleration = -SPEED_back
		else:
			acceleration = initial_accel
	move_and_slide()
