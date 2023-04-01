extends Area


func _ready():
	pass


func _on_Coin_body_entered(body):
	if body.name == "Player":
		Global.update_coins(1)
		queue_free()
