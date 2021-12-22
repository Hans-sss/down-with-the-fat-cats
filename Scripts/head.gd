extends Area2D

signal head_collected

func _on_Head_body_entered(body):
	queue_free()
	if body.is_in_group("Player"):
		collected()
	

func collected():
	emit_signal("head_collected")
	print("head_collected")
	# Global.head_collected = true 
	queue_free()
