extends Area


func _ready():
	pass


func _on_Vending_body_entered(body):
	if body.name == "Player":
		var shop = get_node_or_null("/root/Game/Shop")
		if shop != null:
			shop.open_shop()
