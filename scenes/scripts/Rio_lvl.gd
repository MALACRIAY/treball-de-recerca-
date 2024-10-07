extends Node2D
 
# Export variables to easily configure in the editor
@export var obstacle_scene_1: PackedScene
var spawn_interval : float
var resuelve_prblemas := 0
# Node references
@onready var Animator := $AnimationPlayer
@onready var zona_2 := $"Zona 2"
@onready var spawn_timer: Timer = $SpawnTimer
@onready var spawn_position: Marker2D = $SpawnPosition
@onready var Barco := $Barco
@onready var camera := $Camera2D
@onready var barco_camera := $Barco/camera
var in_wall : bool
var start : bool
func _ready():
	#set_time
	spawn_interval = 5 / GlobalScript.difficulty
	# Start the timer
	spawn_timer.start(spawn_interval)
 
func _on_SpawnTimer_timeout():
	spawn_timer.wait_time = spawn_interval
	if start:
		if Barco.Zona != 4:
			spawn_obstacle()
		else:
			Animator.play("animation")
 
func spawn_obstacle():
	var new_obstacle = obstacle_scene_1.instantiate()
	var random_x = randf_range(-200, 200)
	resuelve_prblemas = Barco.Zona
	if Barco.Zona == 3:
		resuelve_prblemas = 2
	if resuelve_prblemas == 1:
		new_obstacle.rotation += 9
	new_obstacle.global_position = spawn_position.global_position + Vector2(random_x, 0).rotated((2-Barco.Zona)*-90)
	add_child(new_obstacle)
	new_obstacle.add_to_group("obstacles")
	new_obstacle.tree_exited.connect(self._on_Obstacle_tree_exited)
func _on_Obstacle_tree_exited(obstacle: Node):
	obstacle.remove_from_group("obstacles")
 
func _process(delta):
	if start:
		if not Barco.Zona == 4:
			positions()
		else:
			camera.global_position = Vector2(-4200,barco_camera.global_position.y)
			spawn_position.global_position = Vector2(0,0)
 
func positions():
	if Barco.Zona == 2:
		spawn_position.global_position.y = Barco.global_position.y + 800
		camera.global_position = Vector2(0,barco_camera.global_position.y)
	elif Barco.Zona == 1: 
		spawn_position.rotation_degrees = 90
		spawn_position.global_position = Vector2(Barco.global_position.x - 1000, 2700 )
		camera.global_position = Vector2(barco_camera.global_position.x,2300)
	elif Barco.Zona == 3: 
		spawn_position.rotation_degrees = 0
		spawn_position.global_position = Vector2(Barco.global_position.x,Barco.global_position.y + 800)
		camera.global_position = Vector2(-4200,barco_camera.global_position.y)
 
func _on_zona_2_body_entered(body):
	if body == Barco:
		Barco.Zona = 1 # Replace with function body.
 
func _on_zona_3_body_entered(body):
	if body == Barco:
		Barco.Zona = 3
 
func _on_zona_4_body_entered(body):
	if body == Barco:
		Barco.Zona = 4 # Replace with function body.
 
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "animation":
		print("asd")
 
func _on_zona_5_body_entered(body):
	if body == Barco:
		Animator.play("animation")
 
 
func _on_countdown_finished():
	start = true
	Barco.start = true
