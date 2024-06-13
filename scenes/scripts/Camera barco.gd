extends Camera2D
@onready var barco = $"../CharacterBody2D"
var entered = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y = barco.position.y+100
	if entered:
		barco.global_position.y = move_toward(barco.global_position.y,505,barco.VELOCITY)
		if barco.rotation <= 90:
			barco.rotation += delta
func _on_area_2d_body_entered(body):
	if body == barco:
		barco.entered = true
		entered = true
	
