extends Node

var which_player = 0
var player2id = -1

func _unhandled_input(event):
	if event.is_action_pressed("menu"):
		get_tree().quit()
