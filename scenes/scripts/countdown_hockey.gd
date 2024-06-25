extends Node2D
@onready var ch_1 = $"../Character_1"
@onready var stop_2 = $"../Character_2"
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default") 
	
func _process(delta):
	if $AnimatedSprite2D.is_playing():
		$Goals_blue.frame = GlobalScript.points_blue
		$Goals_red.frame = GlobalScript.points_red
	else:
		ch_1.start = true
		$"../Character_2/AnimationPlayer1".play("dif_1")
