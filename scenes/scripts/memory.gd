extends Node2D

# Aquest array ha de tenir els sprites dels "tiles"
var sprites = []

# Desplaçament per centrar el tauler de 2x2
var offset = Vector2(16,19)

func _ready():
	sprites = get_children()  # Assumim que ja tens 16 fills que són els teus sprites.
	place_sprites_on_tiles()

func place_sprites_on_tiles():
	var tilemap = $"../TileMap"  # Obtenim referència al TileMap
	var board_size = tilemap.board_size  # Obtenim la mida del tauler
	var num_tiles = board_size * board_size  # Total de "tiles" visibles
	
	for i in range(sprites.size()):
		var sprite = sprites[i]
		if i < num_tiles:
			# Calculem la posició amb map_to_local
			var tile_pos = tilemap.map_to_local(Vector2(i % board_size, int(i / board_size)))
			
			# Si el tauler és de 2x2, afegim l'offset per centrar
			if board_size == 2:
				sprite.position = tile_pos + offset
			else:
				sprite.position = tile_pos  # Sense offset per a 4x4
				
			sprite.show()  # Mostrem els sprites visibles
		else:
			sprite.hide()  # Amaguem els sprites que no estan dins del taulell

		sprite.add_to_group("hover_click")
		sprite.item_rect_changed.connect($"../TileMap"._on_button_pressed)
