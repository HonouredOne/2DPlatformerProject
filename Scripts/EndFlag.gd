extends Area2D

@export_file("*.tscn") var next_scene

var wind_speed = randf_range(0.5, 2.0)

func _ready():
	$AnimatedSprite2D.speed_scale = wind_speed

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.store_score()
		get_tree().change_scene_to_file(next_scene)

func _process(_delta):
	$AnimatedSprite2D.play()
