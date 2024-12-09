extends Node2D

# Aquest array ha de tenir els sprites dels "tiles"
var sprites = []

# Desplaçament per centrar el tauler de 2x2
var offset = Vector2(16,19)
var num_tiles : int
func _ready():
	sprites = get_children()  # Assumim que ja tens 16 fills que són els teus sprites.
	place_sprites_on_tiles()

func place_sprites_on_tiles():
	var tilemap = $"../TileMap"  # Obtenim referència al TileMap
	var board_size = tilemap.board_size  # Obtenim la mida del tauler
	if GlobalScript.difficulty >= 2:
		num_tiles = 16
	else:
		num_tiles = 4
	
	for i in range(sprites.size()):
		var sprite = sprites[i]
		if i < num_tiles:
			# Calculem la posició amb map_to_local
			var tile_pos = tilemap.map_to_local(Vector2(i % board_size, int(i / board_size)))
			
			# Si el tauler és de 2x2, afegim l'offset per centrar
			if GlobalScript.difficulty >= 2:
				sprite.position = tile_pos 
			else:
				sprite.position = tile_pos + offset# Sense offset per a 4x4
			print(sprite.position)
			sprite.show()  # Mostrem els sprites visibles
		else:
			sprite.hide()  # Amaguem els sprites que no estan dins del taulell

		sprite.add_to_group("hover_click")
		sprite.item_rect_changed.connect($"../TileMap"._on_button_pressed)
