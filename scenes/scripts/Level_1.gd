extends Node2D

# Export variables to easily configure in the editor
@export var obstacle_scene: PackedScene
@export var max_obstacles: int = 10
@export var spawn_interval: float = 2.0

# Node references
@onready var spawn_timer: Timer = $SpawnTimer
@onready var spawn_position: Marker2D = $SpawnPosition

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
	var new_obstacle = obstacle_scene.instantiate()
	# Randomize the position along the width of the river
	var random_x = randf_range(-200, 200)
	new_obstacle.position = spawn_position.position + Vector2(random_x, 0)
	add_child(new_obstacle)
	obstacles.append(new_obstacle)
	new_obstacle.tree_exited.connect(self._on_Obstacle_tree_exited)

func _on_Obstacle_tree_exited(obstacle: Node):
	obstacles.erase(obstacle)
