extends Node
#mapa_global
var level = 3
var difficulty = 2
#personatje
var character_num = 0
func _process(delta):
	hockey()
#Hockey_level
func hockey():
	if points_blue >= 3:
		guanyat = true
	else:
		guanyat = false

var points_blue = 1
var points_red = 1
var guanyat = false
