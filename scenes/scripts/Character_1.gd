extends CharacterBody2D

var Bullet = preload("res://scenes/Levels/objects/Disco.tscn")
var start = false
var max_balls = 1
func _ready():
	
	print("a")


func _physics_process(delta):
	if start:
		if max_balls:
			var b = Bullet.instantiate()
			b.start($"../start".global_position,rotation)
			add_sibling(b)
			max_balls -= 1
		velocity = get_global_mouse_position()-global_position
	move_and_slide()
