extends CharacterBody2D

var move_speed : float = 100.0
var jump_force : float = 250.0
var gravity : float = 500.0

var score : int = PlayerVariables.current_score

@onready var score_text : Label = $CanvasLayer/ScoreText
@onready var _animated_sprite = $AnimatedSprite2D

func _ready():
	score_text.text = str("Score: ", score)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	velocity.x = 0
	
	if Input.is_action_pressed("move_left"):
		velocity.x -= move_speed
	if Input.is_action_pressed("move_right"):
		velocity.x += move_speed
	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
	
	move_and_slide()
	
	if global_position.y > 100:
		game_over()

func _process(_delta):
	if velocity.x != 0 and is_on_floor():
		_animated_sprite.play()
	else:
		_animated_sprite.stop()
	
	if velocity.x > 0:
		_animated_sprite.flip_h = true
	if velocity.x < 0:
		_animated_sprite.flip_h = false

func game_over():
	get_tree().reload_current_scene()

func add_score(amount):
	score += amount
	score_text.text = str("Score: ", score)
	$CoinGet.play()

func store_score():
	PlayerVariables.current_score = score
