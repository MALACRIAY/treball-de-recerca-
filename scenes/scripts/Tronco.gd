extends Area2D

signal obstacle_exited

func _on_VisibilityNotifier2D_screen_exited():
	
	queue_free()
	emit_signal("obstacle_exited")
	
func _on_body_entered(body):
	if body == $"../Mapa":
		visible = false
		if $"../Barco".Zona != 3:
			print($"../Barco".Zona)
			$"..".in_wall = true
			queue_free()
			emit_signal("obstacle_exited")
