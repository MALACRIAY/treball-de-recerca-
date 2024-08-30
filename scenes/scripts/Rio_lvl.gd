extends Node2D

# Export variables to easily configure in the editor
@export var obstacle_scene_1: PackedScene
@export var max_obstacles: int = 100
@export var spawn_interval: float
var resuelve_prblemas = 0
# Node references
@onready var zona_2 = $"Zona 2"
@onready var spawn_timer: Timer = $SpawnTimer
@onready var spawn_position: Marker2D = $SpawnPosition
var obstacles: Array = []
@onready var Barco = $Barco
@onready var camera = $Camera2D
@onready var barco_camera = $Barco/camera
var in_wall
func _ready():
	#set_time
	spawn_interval = 2.0 * (3-GlobalScript.difficulty)
	# Connect the timer signal to the spawn function
	spawn_timer.timeout.connect(self._on_SpawnTimer_timeout)
	# Start the timer
	spawn_timer.start(spawn_interval)

func _on_SpawnTimer_timeout():
	spawn_timer.wait_time = spawn_interval
	if obstacles.size() < max_obstacles:
		spawn_obstacle()

func spawn_obstacle():
	var new_obstacle = obstacle_scene_1.instantiate()
	var random_x = randf_range(-200, 200)
	if Barco.Zona == 1:
		new_obstacle.rotation += 90
	if Barco.Zona == 3:
		new_obstacle.rotation += 9
	new_obstacle.global_position = spawn_position.global_position + Vector2(random_x, 0).rotated((2-Barco.Zona)*-90)
	add_child(new_obstacle)
	obstacles.append(new_obstacle)
	new_obstacle.tree_exited.connect(self._on_Obstacle_tree_exited)
	
func _on_Obstacle_tree_exited(obstacle: Node):
	obstacles.erase(obstacle)

func _process(delta):
	
	
	if Barco.Zona == 2:
		spawn_position.global_position.y = Barco.global_position.y + 800
		camera.global_position = Vector2(0,barco_camera.global_position.y)
		
	elif Barco.Zona == 1: 
		spawn_position.rotation_degrees = 90
		spawn_position.global_position = Vector2(Barco.global_position.x - 1000, 2700 )
		camera.global_position = Vector2(barco_camera.global_position.x,2700)
	elif Barco.Zona == 3: 
		spawn_position.global_position.y = Barco.global_position.y + 800
		camera.global_position = Vector2(-4500,barco_camera.global_position.y)

func _on_zona_2_body_entered(body):
	if body == Barco:
		Barco.Zona = 1 # Replace with function body.

func _on_zona_3_body_entered(body):
	if body == Barco:
		Barco.Zona = 3
