extends CharacterBody2D
@onready var countdown = $"../countdown/AnimatedSprite2D"
@onready var start_player = $"../starter_player_1".global_position
@onready var start_disco = $"../starter_disco".global_position
@onready var anim_enemy = $"../Character_2/AnimationPlayer1"
@onready var disco = %Disco_hockey
@onready var diff = GlobalScript.difficulty
var speed : float
var Bullet = preload("res://scenes/Levels/objects/Disco.tscn")
var start = false
	

func _ready():
	pass

func _physics_process(delta):
	if start:
		velocity = (get_global_mouse_position()-global_position) * 3
	move_and_slide()

func restart():
	restart_player()
	restart_disco()
	restart_countdown()
	animations_enemy()

func spawn():
	disco.start(start_disco,rotation, speed *diff)

func animations_enemy():
	if anim_enemy.is_playing():
		anim_enemy.stop()
	else:
		anim_enemy.play("dif_"+str(diff))

func _on_countdown_animation_finished():
	countdown.visible = false
	start = true
	speed =  100
	animations_enemy()
	spawn() 

func restart_player():
	velocity = Vector2(0,0)
	global_position = start_player
	start = false
func restart_disco():
	speed = 0
	spawn()
func restart_countdown():
	countdown.visible = true
	countdown.play("count")
