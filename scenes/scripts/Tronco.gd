extends Area2D

signal obstacle_exited

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	emit_signal("obstacle_exited")
