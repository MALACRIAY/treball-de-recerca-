extends Node2D

@onready var barra = $barra
@onready var animations = $Flower/Animaciones
@onready var flower = $Flower
@onready var point_marker = $countdown/Points

var flowers_max : int
var side : int
var points = 0
var flowers_left : int
# Called when the node enters the scene tree for the first time.
func _ready():
	animations.speed_scale = (GlobalScript.difficulty)-.5
	flowers_max = GlobalScript.difficulty * 3 - 1
	flowers_left = flowers_max
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


func _on_cesta_red_body_entered(body):
	if body ==  flower:
		if flower.get_child(2).frame != 0:
			points += 1
			$cesta_red/red.play("default")

func _on_cesta_purple_body_entered(body):
	if body ==  flower:
		if flower.get_child(1).frame != 0:
			points +=1
			$cesta_purple/purple.play("default")

func _on_animation_finished(anim_name):
	if anim_name == "top_left" or anim_name == "top_right":
		if side > 0:
			animations.play("bot_right")
		else:
			animations.play("bot_left")
	else:
		if flowers_left > 0:
			#reset flower
			flower.get_child(1).frame = 0
			flower.get_child(2).frame = 0
			flowers_left -= 1
			spawn_flower() 

func _on_countdown_animation_finished():
	spawn_flower()
	%Camera.visible = false


func _on_points_animation_changed():
	print(point_marker.frame)
	print(flowers_max)
	if not flowers_left:
		%Camera.visible = true
		GlobalScript.level += 1
		GlobalScript.just_won = true
		%Camera._change_scene("res://scenes/Levels/Principal.tscn")
		print("sad")
