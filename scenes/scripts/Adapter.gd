extends Control

@onready var loading = $LoadingProgressBar
@onready var timer = $Timer
@onready var fake_light = $TextureRect

var act = true
var hover_time := 0.0  # Temps que el ratolí ha estat a sobre de l'objecte
var hover_threshold = (3-GlobalScript.difficulty)*2 +1 # Temps necessari per simular el clic
var mouse_in : bool
	
func _ready():
	loading.max_value = hover_threshold
	
func _on_mouse_entered():
	hover_time = 0.0
	mouse_in = true  # Activem el processament continu

func _on_mouse_exited():
	hover_time = 0.0
	mouse_in = false

func _process(delta):
	loading.value = hover_time 
	if mouse_in and act:
		hover_time += delta  # Incrementem el temps acumulat
		if hover_time >= hover_threshold:
			_simulate_click_on_all_nodes()
			hover_time = 0.0  # Reiniciem el temporitzador
	if hover_time > 0 and hover_time < .2:
		fake_light.visible = true
	else: 
		fake_light.visible = false
func _simulate_click_on_all_nodes():
	var nodes := get_tree().get_nodes_in_group("hover_click")
	for node in nodes:
		if node.is_hovered():
			_simulate_click(node)

func _simulate_click(node: Node):
	if node is Button or node is TextureButton:
		node.emit_signal("pressed")

func _on_button_pressed():
	print("aaaa") # Replace with function body.


func _on_timer_timeout():
	for object in get_tree().get_nodes_in_group("hover_click"):
		if object is Button or object is TextureButton:
			object.mouse_entered.connect(self._on_mouse_entered)
			object.mouse_exited.connect(self._on_mouse_exited)
