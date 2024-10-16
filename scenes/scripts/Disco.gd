extends CharacterBody2D


func start(_position, _direction, _speed):
	rotation = _direction
	position = _position
	velocity = Vector2(_speed * GlobalScript.difficulty, 0).rotated(rotation)
	push_error(rotation,position,velocity)
func _physics_process(delta):
	look_at(global_position+velocity)
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
 
