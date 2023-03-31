extends Spatial

onready var player1pos = $Player1Pos

func _ready():
	var player = preload("res://Player/Player.tscn").instance()
	player.name = "Player"
	player.global_transform = player1pos.global_transform
	add_child(player)
