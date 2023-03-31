extends Sprite3D

onready var bar = $Viewport/HealthBar2D
var bar_green = Color8(64,192,87)
var bar_yellow = Color8(255,212,59)
var bar_red = Color8(201,42,42)

func _ready():
	texture = $Viewport.get_texture()

func update(amount, full):
	bar.get("custom_styles/fg").bg_color = bar_green
	if amount < 0.75 * full:
		bar.get("custom_styles/fg").bg_color = bar_yellow
	if bar.value < 0.45 * full:
		bar.get("custom_styles/fg").bg_color = bar_red
	bar.value = amount
