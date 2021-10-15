extends Node2D

var coins = Global.coins

func _on_Coin_coin_collected():
	$coin.play()
	print("coin before", Global.coins, coins)
	coins = coins + 1
	var Coinscore = "Coins: " +String(coins)
	Global.coins += 1
	print("coin updated", Global.coins, coins)


func _on_AreaTrigger_body_entered(body):
	$aw.play()
	print("msuk trigger 2")
	coins = 0
	var Coinscore = "Coins: " +String(coins)
	Global.coins = 0


func _on_Player_dead():
	coins = 0
	var Coinscore = "Coins: " +String(coins)
	Global.coins = 0


func _on_Player_kill():
	pass # Replace with function body.


#func _on_Player_coin_donated():
	#coins -= 1
	#var Coinscore = "Coins: " +String(coins)
	#Global.coins -= 1
	#if coins == 0:
		#game_end()
		
func _on_Player_guard_paid():
	if coins >= 5:
		coins -= 5
		var Coinscore = "Coins: " +String(coins)
		Global.coins -= 5
		
func game_end():
	print("it's over")
	get_tree().change_scene(str("res://Scenes/" + "Win Screen" + ".tscn"))
