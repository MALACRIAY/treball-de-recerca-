extends CharacterBody2D

func _physics_process(delta):
	if $"../countdown/Hidden_timer".time_left == 0:
		velocity = $"../Disco".global_position-global_position
	move_and_slide()
