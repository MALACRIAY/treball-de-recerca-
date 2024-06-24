extends Node2D
@onready var stop_1 = $"../Character_1"
@onready var stop_2 = $"../Character_2"
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default") # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $AnimatedSprite2D.is_playing():
		stop_1.set_physics_process(false)
		$Goals_blue.frame = GlobalScript.points_blue
		$Goals_red.frame = GlobalScript.points_red
	elif $AnimatedSprite2D.frame >= 1:
		stop_1.set_physics_process(true)
func _initialize():
	print("Initialized:")
	print("  Starting time: %s" % str(0))
