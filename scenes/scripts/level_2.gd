extends Node2D
@export var flowers_max : int
@onready var barra = $barra
@onready var animations = $Animaciones
@export var flower_scene: PackedScene
@export var spawn_interval : int
@onready var spawn_timer : Timer = $SpawnTimer
@onready var flower = $Flower
@onready var point_marker = $countdown/Points
var side : int
var points = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _process(delta):
	side = sign(get_global_mouse_position().x - barra.global_position.x )
	barra.rotation_degrees = move_toward(barra.rotation_degrees,15 * side,1) 
	# barra costat
	point_marker.frame = points
func spawn_flower():
	var color = flower.get_child(randi_range(1,2))
	color.frame = randi_range(1,3)
	var rand_size = randf_range(1.8,3)
	flower.scale = Vector2(rand_size,rand_size)
	if not animations.is_playing():
		var rand_side =  randi_range(0,1)
		if rand_side:
			animations.play("top_left")
		else:
			animations.play("top_right")
"	var flower = flower_scene.instantiate()
	flower.global_position = Vector2(1500,0)
	add_child(flower)
	
	flower.set_name(Flower)
	print(flower.name)
	add_child(flower)"

func _on_cesta_red_body_entered(body):
	if body ==  flower:
		if flower.get_child(2).frame != 0:
			points += 1


func _on_cesta_purple_body_entered(body):
	if body ==  flower:
		if flower.get_child(1).frame != 0:
			points +=1


func _on_animation_finished(anim_name):
	if anim_name == "top_left" or anim_name == "top_right":
		if side > 0:
			animations.play("bot_right")
		else:
			animations.play("bot_left")
	else:
		if flowers_max > 0:
			#reset flower
			flower.get_child(1).frame = 0
			flower.get_child(2).frame = 0
			flowers_max -= 1
			print(flowers_max)
			spawn_flower() 
func _on_timeout():
	spawn_flower()
