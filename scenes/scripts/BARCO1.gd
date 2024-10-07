extends CharacterBody2D
 
@export var acceleration: float = 40.0
@export var max_speed : float = 80.0 * GlobalScript.difficulty
@export var min_angle := 130
@export var max_angle := 230
 
var speed : float
var animations : Array
var Zona = 2
var resolvedor_de_problemas = 90
var health = 6
var lost := false
var start : bool

func _ready():
	for box in $boxes.get_children():
		animations.append(box.get_child(0))
 
func _process(delta):
	if start:
		if Zona != 4:
			movement(delta)
 
func movement(delta):
	if Zona == 1:
		resolvedor_de_problemas = 0
	elif Zona == 2 or 3:
		resolvedor_de_problemas = 90
	look_at(get_global_mouse_position())
	rotation_degrees += resolvedor_de_problemas
	if rotation_degrees < 0:
		rotation_degrees = 360 + rotation_degrees
	if rotation_degrees < min_angle:
		rotation_degrees = min_angle
	elif rotation_degrees >= max_angle:
		rotation_degrees = max_angle
	if max_speed > speed:
		speed += acceleration * delta * GlobalScript.difficulty
	rotation_degrees += 90-resolvedor_de_problemas
	#print("ROTACION"+ str(rotation_degrees))
	velocity = Vector2(speed, 0).rotated(deg_to_rad(rotation_degrees-90))
	move_and_slide()
 
func lost_health():
	health -= 1
	animations[health].play(str(health))
 
func _on_Barco_body_entered(body):
	if body.is_in_group("obstacles"):
		lost_health()
		body.get_child(0).play("Disapear",-1,4.0)
		speed -= speed/(4-GlobalScript.difficulty)
