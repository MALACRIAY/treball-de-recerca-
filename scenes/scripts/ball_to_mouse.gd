extends Area2D

var file_path = "res://opencv(TR)/coordinates.json"
var last_position = Vector2.ZERO
var smoothing_factor = 0.1  # Adjust this value to control the smoothing
var speed = 100
#max = (1268,472) 
#min = (0,0)
#arriba a (489,355)
func _ready():
	# Initialize the last position of the object
	check_for_updates()
	pass
func _process(delta):
	# Check for updates at each frame
	check_for_updates()
	#global_position = get_global_mouse_position()
	# Smoothly interpolate towards the target position using lerp

	
	#print(position)
func check_for_updates():
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file:
		var json_text = file.get_as_text()
		file.close()

		# Assuming the file contains the string "x, y"
		var coordinates = json_text.strip_edges().split(", ")
		if coordinates.size() == 2:
			var x = int(coordinates[0]) * 2
			var y = int(coordinates[1])
			print(x*0.90851735015,"+",y*1.37288135593)
			# Update last position
			last_position = Vector2(int(x*0.90851735015),int(y*1.37288135593))
		else:
			print("Error: Coordinates are not in the expected format.")
	else:
		print("File not found: ", file_path)
	position = position.lerp(last_position, smoothing_factor)
