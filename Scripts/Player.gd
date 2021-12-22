extends KinematicBody2D

#signal health_updated(health)
#signal killed()

signal dead
signal kill
signal coin_donated
signal guard_bribed

export (int) var speed = 300
export (int) var mid_air_speed = 250
export (int) var GRAVITY = 1800
export (int) var jump_speed = -480
export (int) var mid_air_jump_speed = -350
export (int) var health = 3
#export (float) var max_health = 100

#onready var health = max_health setget _set_health

const UP = Vector2(0,-1)

var velocity = Vector2()
var animation = "stand_right"
var last_dir = "right"
var extra_jump_count = 2
var attacking = false
var villager = null
var gatekeeper = null
			
			
func _ready():
	Global.player = self
	if self.get_parent().name == "PoorsvilleEnd":
		print("abc")
		$bullhead.visible = true
	
func _exit_tree():
	Global.player = null
	
func set_dir():
	if last_dir == "right":
		animation = "stand_right"
	else:
		animation = "stand_left"
	
func get_input():
	velocity.x = 0
	if Input.is_action_just_pressed('up'):
		if is_on_floor():
			$jump.play()
			velocity.y = jump_speed
			#$AudioStreamPlayer2D.play()
		elif extra_jump_count != 0:
			$jump.play()
			velocity.y = mid_air_jump_speed
			extra_jump_count = extra_jump_count-1
		set_dir()

	elif  Input.is_action_pressed('right'):
		if is_on_floor():
			velocity.x += speed
		else:
			velocity.x += mid_air_speed
		animation = "walk_right"
		last_dir = "right"
		
	elif Input.is_action_pressed('left'):
		if is_on_floor():
			velocity.x -= speed
		else:
			velocity.x -= mid_air_speed
		animation = "walk_left"
		last_dir = "left"
	
	if Input.is_action_pressed('attack') and is_on_floor():
		attacking = true
		speed = 80
		if last_dir == "right":
			animation = "attack_right"
		else:
			animation = "attack_left"
	else:
		speed = 300
		attacking = false
	
	if Input.is_action_just_pressed("coin"):
		if villager != null:
			$thanks.play()
			emit_signal("coin_donated")
			villager.happy()
		elif gatekeeper != null:
			if Global.coins >= 5:
				$thanks.play()
				Global.coins -= 5
				emit_signal("guard_bribed")
				gatekeeper.paid()
			
	
	if is_on_floor():
		extra_jump_count=2
		
	if is_on_floor() and !Input.is_action_pressed('right') and !Input.is_action_pressed('left') and !Input.is_action_pressed('down') and !Input.is_action_pressed('attack'):
		set_dir()
		
	if $AnimatedSprite.animation != animation:
		$AnimatedSprite.play(animation)

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	get_input()
	velocity = move_and_slide(velocity, UP)
	
#func damage(amount):
#	_set_health(health-amount)
	
#func kill():
#	pass

#func _set_health(value):
#	var prev_health = health
#	health = clamp (value, 0, max_health)
#	if health != prev_health:
#		emit_signal("health_updated", health)
#		if health == 0:
#			kill()
#			emit_signal("killed")



func _on_Area2D_area_entered(area):
	print(area.name)
	if area.is_in_group("Enemy"):
		if !attacking:
			$aw.play()
			health -= 1
			if health == -1:
				emit_signal("dead")
				get_tree().change_scene(str("res://Scenes/" + "GameOver" + ".tscn"))
		else:
			emit_signal("kill") 
			if "Evil" in area.name:
				area.dead()
	if area.is_in_group("Head"):
		$bullhead.visible = true
		area.queue_free()
	if area.is_in_group("Villager"):
		print("hehe this works")
		villager = area
	if area.is_in_group("GateKeeper"):
		$gimmemonney.play()
		print("hehe this works")
		gatekeeper = area
	if area.is_in_group("ExtraHealth"):
		if health < 3:
			health += 1
		area.queue_free()
		
#func _on_Area2D_area_exited(area):
	#print(area.name)
		
#func _on_Villager_area_entered(area):
#	print("hmmmm", area.name)
#	if area.is_in_group("Villager"):
#		print("hehe this also works")
#		villager = null
		
func _on_Villager_area_exited(area):
	print("leave")
	villager = null

func _on_GateKeeper_area_exited(area):
	print("leave")
	gatekeeper = null
	
		


#func _on_Villager_area_entered(area):
	#villager = area
	#print("entered ", area.name)

