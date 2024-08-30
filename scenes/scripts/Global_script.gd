extends Node
#mapa_global
var level = 3
var difficulty = 8
#personatje
var character_num = 0
func _process(delta):
	#hockey
	if points_blue >= 3:
		guanyat = true
	else:
		guanyat = false
#Hockey_level
var points_blue = 2
var points_red = 5
var guanyat = false
