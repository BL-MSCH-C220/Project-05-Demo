extends Control

var health_cost = 1
var ammo_cost = 1

func _ready():
	pass

func open_shop():
	show()
	disable_buttons()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true

func _on_Health_pressed():
	Global.update_coins(-1)
	Global.update_health(20)
	disable_buttons()


func _on_Ammo_pressed():
	Global.update_coins(-1)
	Global.update_ammo(20)
	disable_buttons()


func disable_buttons():
	$Health.disabled = false
	$Ammo.disabled = false
	if Global.coins < health_cost:
		$Health.disabled = true
	if Global.coins < ammo_cost:
		$Ammo.disabled = true


func _on_Button_pressed():
	hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
