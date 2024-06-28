extends Node2D

# Export variables to easily configure in the editor
@export var obstacle_scene_1: PackedScene
@export var max_obstacles: int = 100
@export var spawn_interval: float = 2.0

# Node references
@onready var spawn_timer: Timer = $SpawnTimer
@onready var spawn_position: Marker2D = $Node2D/SpawnPosition
var speed = 100
var obstacles: Array = []

func _ready():
	# Connect the timer signal to the spawn function
	spawn_timer.timeout.connect(self._on_SpawnTimer_timeout)
	# Start the timer
	spawn_timer.start(spawn_interval)

func _on_SpawnTimer_timeout():
	if obstacles.size() < max_obstacles:
		spawn_obstacle()

func spawn_obstacle():
	var new_obstacle = obstacle_scene_1.instantiate()
	# Randomize the position along the width of the river
	var random_x = randf_range(-200, 200)
	new_obstacle.global_position = spawn_position.global_position + Vector2(random_x, 0)
	print(spawn_position.global_position)
	add_child(new_obstacle)
	obstacles.append(new_obstacle)
	new_obstacle.tree_exited.connect(self._on_Obstacle_tree_exited)
	
func _on_Obstacle_tree_exited(obstacle: Node):
	obstacles.erase(obstacle)
