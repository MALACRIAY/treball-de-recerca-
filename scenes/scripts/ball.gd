extends CharacterBody2D

signal shot
var speed : float
var min_size = Vector2(.5,.5)
var decrease_speed = 5
func _physics_process(delta):
	speed = GlobalScript.difficulty + 1
	decrease_speed = (GlobalScript.difficulty +1) *5
	velocity = (get_global_mouse_position()-global_position)* 5 / speed
	if scale >= min_size:
		scale -= Vector2(delta/decrease_speed,delta/decrease_speed)
	else:
		emit_signal("shot")
	move_and_slide()
