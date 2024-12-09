extends Area2D

var file_path = "res://opencv(TR)/coordinates.json"
var last_position = Vector2.ZERO
var smoothing_factor = 0.1  # Adjust this value to control the smoothing
var speed = 100
var dimensions = Vector2(640,360)
var transformer_x = ProjectSettings.get_setting("display/window/size/viewport_width")/dimensions.x
var transformer_y = ProjectSettings.get_setting("display/window/size/viewport_height")/dimensions.y

#portatil = (1268,472) 
#camera(640,360)
#min = (0,0)
#arriba a (489,355)

func _ready():
	# Initialize the last position of the object
	check_for_updates()
	pass
func _process(_delta):
	# Check for updates at each frame
	#check_for_updates()
	global_position = get_global_mouse_position()
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
			var x = int(coordinates[0]) * transformer_x
			var y = int(coordinates[1]) * transformer_y

			# Update last position
			last_position = Vector2(int(x),int(y))
		else:
			print("Error: Coordinates are not in the expected format.")
	else:
		print("File not found: ", file_path)
	position = position.lerp(last_position, smoothing_factor)
