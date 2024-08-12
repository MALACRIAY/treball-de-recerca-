extends Area2D

func _ready():
	$AnimatedSprite2D.frame = randi_range(0,1)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free() # Replace with function body.
