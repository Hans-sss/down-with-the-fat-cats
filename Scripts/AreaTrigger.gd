extends Area2D

export (String) var sceneName = "Level 1"

func _on_AreaTrigger_body_entered(body):
	if body.get_name() == "Player":
		#emit_signal("reset_level")
		print("masuk trigger")
		get_tree().change_scene(str("res://Scenes/" + sceneName + ".tscn"))
	
