extends TileMap

var board_size = 2
enum Layers{hidden,revealed}
var SOURCE_NUM = 0
const hidden_tile_coords = Vector2(1,1)
const hidden_tile_alt = 1
var revealed_spots = []
var tile_pos_to_atlas_pos = {}
var score = 0
var turns_taken = 0
var button_number = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if GlobalScript.difficulty >= 2:
		
		board_size = 4
	else:
		scale = Vector2(8,8)
		$"../buttons".scale = Vector2(8,8)
		$"../buttons".position = Vector2(269,-100)
	setup_board()
	update_text()
	pass # Replace with function body.

func get_tiles_to_use():
	var chosen_tile_coords = []
	var options = range(10)
	options.shuffle()
	for i in range(board_size * int(board_size / 2)):
		var current = Vector2(options.pop_back(), 0)
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
			var posicion = map_to_local(current_spot)
			var botones = $"../buttons"
			botones.get_child(button_number).position = posicion
			button_number += 1
			
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
	check_win()

func put_back_cards_with_delay():
	await self.get_tree().create_timer(1.5).timeout
	for spot in revealed_spots:
		place_single_face_down_card(spot)
	revealed_spots.clear()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed():
	var global_clicked = %Camera.ball.global_position
	var pos_clicked = Vector2(local_to_map(to_local(global_clicked)))
	var current_tile_alt = get_cell_alternative_tile(Layers.hidden, pos_clicked)
	if current_tile_alt == 1 and revealed_spots.size() < 2:
		self.set_cell(Layers.hidden, pos_clicked, -1)
		revealed_spots.append(pos_clicked)
		if revealed_spots.size() == 2:
			when_two_cards_revealed()

func check_win():
	if score == (board_size**2)/2:
		await self.get_tree().create_timer(1.5).timeout
		GlobalScript.level += 1
		%Camera._change_scene("res://scenes/Levels/Principal.tscn")
	$"../Label2".get_child(0).frame = score
	$"../Label3".get_child(0).frame = turns_taken
	if turns_taken >= 20:
		get_tree().reload_current_scene()
