extends CharacterBody2D

var Bullet = preload("res://scenes/Levels/objects/Disco.tscn")
var i = 0

func _ready():
	
	print("a")


func _physics_process(delta):
	if i == 2:
		var b = Bullet.instantiate()
		b.start($"../start".global_position,rotation)
		add_sibling(b)
	i += 1
	
	velocity = get_global_mouse_position()-global_position
	move_and_slide()
