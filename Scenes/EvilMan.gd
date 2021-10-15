extends Area2D

var is_dead = false

func _ready():
	pass # Replace with function body.

func dead():
	is_dead = true
	queue_free()



