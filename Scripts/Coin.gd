extends Area2D

@export_range(1, 10, 1) var value = 1

var bob_height : float = 7.0
var bob_speed : float = 10.0

@onready var start_y : float = global_position.y
var t : float = 0.0

func _process(delta):
	t += delta
	
	var d = (sin(t * bob_speed) + 1) / 2
	global_position.y = start_y + (d * bob_height)


func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.add_score(value)
		queue_free()
