extends Node2D
 
# Export variables to easily configure in the editor
@export var obstacle_scene : PackedScene
@onready var obstacle_scene_1 = preload("res://scenes/objects/Tronco.tscn")
@onready var Animator := $Animations/AnimationPlayer
@onready var spawn_position: Marker2D = $obstacles
@onready var Barco := $Barco

var in_wall : bool
var spawn_interval : float

func _ready():
	#set_time
	spawn_interval = 5.0 / GlobalScript.difficulty
	# Start the timer
	await self.get_tree().create_timer(2).timeout
	_on_SpawnTimer_timeout()
 
func _on_SpawnTimer_timeout():
	await self.get_tree().create_timer(spawn_interval).timeout
	if Barco.Zona < 3:
		spawn_obstacle()
		_on_SpawnTimer_timeout()
 
func spawn_obstacle():
	var new_obstacle = obstacle_scene.instantiate()
	var random_x = randf_range(-200, 200)
	add_child(new_obstacle)
	if not Barco.Zona == 2 :
		new_obstacle.rotation += 2
		new_obstacle.global_position = spawn_position.global_position + Vector2(random_x, 0)
	elif Barco.Zona == 2:
		new_obstacle.global_position = spawn_position.global_position + Vector2(0,random_x)
	
	new_obstacle.add_to_group("obstacles")
	new_obstacle.tree_exited.connect(self._on_Obstacle_tree_exited)
	
func _on_Obstacle_tree_exited(obstacle: Node):
	obstacle.remove_from_group("obstacles")
 


func _on_animation_finished(_anim_name):
	GlobalScript.level += 1
	GlobalScript.just_won = true
	%Camera._change_scene("res://scenes/Levels/Principal.tscn")
