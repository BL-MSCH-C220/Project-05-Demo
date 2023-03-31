extends Control

func _ready():
	$Player.text = "Player " + str(Global.which_player)
