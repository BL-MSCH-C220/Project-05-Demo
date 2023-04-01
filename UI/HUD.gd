extends Control

func _ready():
	$Player.text = "Player " + str(Global.which_player)
	update_coins()

func update_coins():
	$Coins.text = "Coins: " + str(Global.coins)
