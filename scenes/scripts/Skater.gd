extends CharacterBody2D

@onready var skater = $Area2D
@onready var skate_color = $skate
@onready var animations = $"../AnimationPlayer"
@onready var coins_count = $AnimatedSprite2D
@export var scene_pedra :PackedScene
@export var scene_coin : PackedScene

var pedras : Array
var coins : Array
const zonas : Array =[ 130,230,330]
var zona : int = 2
var mouse_zona : int
const SPEED = 100.0
var amount_of_coins = 0
var max_coins : int
var zona_to : int = 1

func _ready():
	_set_difficulty()
func set_zones():
	var mouse_height = get_global_mouse_position().y
	if mouse_height > 262:
		mouse_zona = 3
	elif mouse_height < 162:
		mouse_zona = 1
	elif mouse_height > 162 and mouse_height < 262:
		mouse_zona = 2
	if skater.global_position.y <= 200:
		zona = 1
	elif skater.global_position.y >= 300:
		zona = 3
	elif skater.global_position.y > 100 and skater.global_position.y < 300:
		zona = 2
		
func _physics_process(delta):
	coins_count.frame = amount_of_coins
	if amount_of_coins >= max_coins:
		get_tree().change_scene_to_file("res://scenes/Levels/level_2.tscn")
	if not animations.is_playing():
		set_zones()
		animations.play(str(zona)+"to"+str(mouse_zona))
	move_and_slide()

func _set_difficulty():
	var diff = GlobalScript.difficulty
	velocity.x = SPEED * diff
	animations.speed_scale = diff
	max_coins = 2*diff

func _on_timer_timeout():
	var pedra = scene_pedra.instantiate()
	var coin = scene_coin.instantiate()
	var rand_y_p = zonas.pick_random()
	var rand_y_c = zonas.pick_random()
	pedra.global_position = Vector2(global_position.x+1000,rand_y_p)
	add_sibling(pedra)
	pedras.append(pedra)
	if not rand_y_c == rand_y_p:
		coin.global_position = Vector2(global_position.x+1000,rand_y_c)
		add_sibling(coin)
		coins.append(coin)

func _pedra_area_entered(body):
	if body in pedras:
		velocity = Vector2(0,0)
		animations.play("Dead")
	elif body in coins:
		AnimatedSprite2D
		body.get_child(0).play("default")
		amount_of_coins += 1

func _on_animation_finished(anim_name):
	if anim_name == "Dead":
		get_tree().change_scene_to_file("res://scenes/Levels/level_2.tscn") # Replace with function body.
