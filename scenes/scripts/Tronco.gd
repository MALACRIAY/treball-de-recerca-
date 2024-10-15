extends Area2D

signal obstacle_exited

func _on_VisibilityNotifier2D_screen_exited():
	
	queue_free()
	emit_signal("obstacle_exited")
	
func _on_body_entered(body):
	print(body)
	if body == $"../Mapa":
		visible = false
		$"..".in_wall = true
	if body == $"../Barco":
		print(body)
		await self.get_tree().create_timer(1) .timeout
		emit_signal("obstacle_exited")
		queue_free()
