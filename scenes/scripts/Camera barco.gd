extends Camera2D
@onready var barco = $"../CharacterBody2D"
var entered = false
# Called when the node enters the scene tree for the first time.
func _ready():
	for area in $"../objects".get_children():
		area.body_entered.connect(_on_body_entered.bind(area)) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
	
func _on_body_entered(body,area):
	barco.get_child(0).play("spin",-1,5)
	
	AnimationPlayer
