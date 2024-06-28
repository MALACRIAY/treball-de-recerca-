extends CharacterBody2D

@export var acceleration: float = 100.0
@export var max_speed : float = 200.0
var speed : float

func _ready():
	pass

func _process(delta):
	look_at(get_global_mouse_position())
	if max_speed > speed:
		speed += acceleration * delta
	print(speed)
	velocity = Vector2(speed, 0).rotated(rotation)
	move_and_collide(velocity * delta)

func _on_Barco_body_entered(body):
	if body.is_in_group("obstacles"):
		speed -= 50  # Reduce la velocidad al chocar con un obstáculo
		body.queue_free()  # Eliminar el obstáculo (opcional)
