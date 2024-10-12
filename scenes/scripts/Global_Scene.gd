extends Node2D

@onready var Camera = %Camera
@onready var Anim = %Scene_change
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Camera.zoom = Vector2(8/Anim.scale.x,8/Anim.scale.y)
