extends Camera2D

@onready var camera = self
@onready var Anim = %Scene_change
@onready var ball = %Ball
@onready var clock = %Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Anim.play("default")
	_set_initials()
# Called every frame. 'delta' is the elapsed time since the previous frame.
	
func _set_initials():
	if GlobalScript.Global_Scene_black:
		Anim.frame = 10
	else: 
		Anim.frame = 0
	#ball.visible = true

func _process(delta):
	camera.zoom = Vector2(1/self.scale.x,1/self.scale.y)
	
func _change_scene(scene):
	Anim.play_backwards("default")
	await self.get_tree().create_timer(0.7).timeout
	get_tree().change_scene_to_file(scene)

func _on_frame_changed():
	pass
