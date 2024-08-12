extends CharacterBody2D

var speed = 750

func start(_position, _direction):
	
	rotation = _direction
	position = _position
	velocity = Vector2(speed, 0).rotated(rotation)/5

func _physics_process(delta):
	look_at(global_position+velocity)
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
