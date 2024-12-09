extends Node2D

@onready var area = $Area2D
@onready var ball =  $"../Ball"
@onready var loading = $LoadingProgressBar
@onready var fake_light = $TextureRect

var act = true
var hover_time := 0.0  # Temps que el ratolí ha estat a sobre de l'objecte
var hover_threshold = (3-GlobalScript.difficulty)*2 +1 # Temps necessari per simular el clic
var nodes_in : Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(.05).timeout
	loading.max_value = hover_threshold
	var nodes := get_tree().get_nodes_in_group("hover_click")
	for node in nodes:
		if node is Sprite2D:
			var tween = area.duplicate(1)
			node.add_child(tween)
			tween.global_position = node.global_position
			tween.area_entered.connect(self._area_entered.bind(tween))
			tween.area_exited.connect(self._area_exited.bind(tween))
			var shape = tween.get_child(0).shape.duplicate()
			tween.get_child(0).shape = shape
			
			if node.region_enabled:
				shape.size = Vector2(node.region_rect.size.x, node.region_rect.size.y)
			else:
				shape.size = Vector2(node.texture.get_width() , node.texture.get_height())


func _area_entered(mouse,area):
	if mouse == ball:
		nodes_in.append(area)
	pass # Replace with function body.

func _area_exited(_mouse,area):
	if area in nodes_in:
		nodes_in.erase(area)
	pass

func _process(delta):
	loading.value = hover_time 
	#print(nodes_in)
	if nodes_in:
		hover_time += delta
		if hover_time >= hover_threshold:
			_simulate_click_on_all_nodes()
			hover_time = 0.0  # Reiniciem el temporitzador
	else:
		hover_time = 0.0
	if hover_time > 0 and hover_time < .2:
		fake_light.visible = true
	else: 
		fake_light.visible = false
		
func _simulate_click_on_all_nodes():
	var node = nodes_in[0]
	if node :
		node.get_parent().emit_signal("item_rect_changed")
		get_parent()
