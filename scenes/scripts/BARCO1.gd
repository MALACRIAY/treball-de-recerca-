extends CharacterBody2D
 

@onready var obstacles : = $"../obstacles"
@onready var Zones := $"../Zones"
@onready var textos := $"../Textos".get_children()
@onready var camera := %Camera
@onready var anim_start = $"../Animations/start".global_position
@onready var anim := $"../Animations/AnimationPlayer"
var acceleration: float = 200
var max_speed : float
var speed : float = 0
var animations : Array
var Zona = 1
var resolvedor_de_problemas = 90
var health = 6
var lost := false
var move := false

func _ready():
	camera.get_child(1).visible = false
	print(%Camera)
	for box in $boxes.get_children():
		animations.append(box.get_child(0))
	for area in Zones.get_children():
		area.body_entered.connect(_on_zona_entered.bind(area.get_index()+1))
	max_speed = 80.0 * GlobalScript.difficulty
	await self.get_tree().create_timer(2).timeout
	move = true
	
func _process(delta):
	camera.global_position = global_position + Vector2(-600,-300)
	if move:
		_set_obstacles()
		look_at_mouse(delta)
		if Zona == 4:
			print(global_position," + ", anim_start)
			global_position.x = move_toward(global_position.x,anim_start.x,3)
			global_position.y = move_toward(global_position.y,anim_start.y,3)
			
func look_at_mouse(delta):
	if Zona < 4:
		if speed < max_speed:
			speed += delta * acceleration
		look_at(camera.get_child(0).global_position)
		rotation_degrees += 90
		velocity = Vector2(speed, 0).rotated(deg_to_rad(rotation_degrees -90))
		velocity.normalized()
		move_and_slide()

func lost_health():
	health -= 1
	if health < -7:
		health = -7
	animations[health].play(str(health))
 
func _on_Barco_body_entered(body):
	if body.is_in_group("obstacles"):
		lost_health()
		body.get_child(0).play("Disapear",-1,GlobalScript.difficulty*2)
		speed -= speed/(4-GlobalScript.difficulty)
	
	

func _set_obstacles():
	if Zona == 1 or Zona == 3:
		obstacles.global_position = global_position + Vector2(0,400)
	elif Zona == 2:
		obstacles.global_position = global_position + Vector2(-650,0)

func _on_zona_entered(body,index):
	if body == self:
		Zona = index
		if index == 4:
			await  self.get_tree().create_timer(1).timeout
			anim.play("final")
