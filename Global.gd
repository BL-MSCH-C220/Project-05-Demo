extends Node

var which_player = 0
var player2id = -1

var coins = 0
var health = 50
var ammo = 50

func _unhandled_input(event):
	if event.is_action_pressed("menu"):
		get_tree().quit()

func update_coins(c):
	coins += c
	var HUD = get_node_or_null("/root/Game/HUD")
	if HUD != null:
		HUD.update_coins()

func update_health(h):
	health += h
	print(health)

func update_ammo(a):
	ammo += a
	print(ammo)
