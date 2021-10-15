extends Area2D


export (String) var sceneName = "Level 1"


func paid():
	print("you can go through now")
	get_tree().change_scene(str("res://Scenes/" + sceneName + ".tscn"))
