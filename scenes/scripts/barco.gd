extends CharacterBody2D

@export var speed = 200

func _ready():
	pass

func _process(delta):
	velocity.y = speed
	move_and_collide(velocity * delta)

func _on_Barco_body_entered(body):
	if body.is_in_group("obstacles"):
		speed -= 50  # Reduce la velocidad al chocar con un obstáculo
		body.queue_free()  # Eliminar el obstáculo (opcional)
