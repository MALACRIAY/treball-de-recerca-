extends TileMap

var board_size = 4
enum Layers{hidden,revealed}
var SOURCE_NUM = 0
const hidden_tile_coords = Vector2(6,2)
const hidden_tile_alt = 1
var revealed_spots = []
var tile_pos_to_atlas_pos = {}
var score = 0
var turns_taken = 0
var set_timer = false
@onready var hover_timer := $"../Timer"
var hovered_tile : Vector2 = Vector2(-1, -1) 
@onready var timer = $"../Timer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	setup_board()
	update_text()
	scale = Vector2(16/board_size,16/board_size)
	pass # Replace with function body.
func get_tiles_to_use():
	var chosen_tile_coords = []
	var options = range(10)
	options.shuffle()
	for i in range(board_size * int(board_size / 2)):
		print(options)
		if options.size() == 1:
			options = range(10)
		var current = Vector2(options.pop_back(), 1)
		for j in range(2):
			chosen_tile_coords.append(current)
	chosen_tile_coords.shuffle()
	return chosen_tile_coords

func setup_board():
	var cards_to_use = get_tiles_to_use()
	for y in range(board_size):
		for x in range(board_size):
			var current_spot = Vector2(x, y)
			place_single_face_down_card(current_spot)
			var card_atlas_coords = cards_to_use.pop_back()
			tile_pos_to_atlas_pos[current_spot] = card_atlas_coords
			self.set_cell(Layers.revealed, current_spot, 
						SOURCE_NUM, card_atlas_coords)


func place_single_face_down_card(coords: Vector2):
	self.set_cell(Layers.hidden, coords, 
				SOURCE_NUM, hidden_tile_coords, hidden_tile_alt)

func when_two_cards_revealed():
	# the cards match
	if tile_pos_to_atlas_pos[revealed_spots[0]] == tile_pos_to_atlas_pos[revealed_spots[1]]:
		score += 1
		revealed_spots.clear()
	else:
		# the cards did not match
		put_back_cards_with_delay()
	turns_taken += 1
	update_text()

func update_text():
	$"../CanvasLayer/score_label".text = "Score: %d" % score
	$"../CanvasLayer/turns_label".text = "Turns Taken: %d" % turns_taken
	


func put_back_cards_with_delay():
	await self.get_tree().create_timer(1.5).timeout
	for spot in revealed_spots:
		place_single_face_down_card(spot)
	revealed_spots.clear()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$"../AnimatedSprite2D".frame = int(timer.time_left*2)+1.5
	var global_mouse_position = get_global_mouse_position()
	var local_mouse_position = to_local(global_mouse_position)
	var pos_clicked = Vector2(local_to_map(local_mouse_position))
	
	if is_mouse_over_tile(pos_clicked):
		if pos_clicked != hovered_tile:
			hovered_tile = pos_clicked
			hover_timer.start()
	else:
		hovered_tile = Vector2(-1, -1)
		hover_timer.stop()

func is_mouse_over_tile(pos):
	var map_bounds = get_used_rect()
	return pos.x >= map_bounds.position.x and pos.x < map_bounds.position.x + map_bounds.size.x and pos.y >= map_bounds.position.y and pos.y < map_bounds.position.y + map_bounds.size.y

func _on_hover_timeout():
	if hovered_tile != Vector2(-1, -1):
		var current_tile_alt = get_cell_alternative_tile(Layers.hidden, hovered_tile)
		if current_tile_alt == 1 and revealed_spots.size() < 2:
			set_cell(Layers.hidden, hovered_tile, -1)
			revealed_spots.append(hovered_tile)
			if revealed_spots.size() == 2:
				when_two_cards_revealed()
