extends Area2D


func happy():
	if Global.coins > 0:
		Global.coins -= 1
		print(self.get_parent().name, Global.coins)
		if self.get_parent().name == "PoorsvilleEnd":
			if Global.coins==0:
				get_tree().change_scene(str("res://Scenes/" + "Win" + ".tscn"))
		print("oh my god this works!")
