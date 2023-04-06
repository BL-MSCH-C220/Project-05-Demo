extends KinematicBody

onready var camera = $Pivot/Camera
onready var Decal = load("res://Player/Decal.tscn")

var speed = 5
var gravity = -8.0
var direction = Vector3()
var mouse_sensitivity = 0.001
var precision_sensitivity = 0.01
var mouse_range = 1.2
var velocity = Vector2.ZERO

var precision = false
var pivot_position = Vector3.ZERO
var precision_range = 2.0


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Pivot/Camera.current = true
	pivot_position = $Pivot.translation

func _physics_process(_delta):
	velocity = get_input()*speed
	velocity.y += gravity
	if is_on_floor():
		velocity.y = 0

	if velocity != Vector3.ZERO:
		velocity = move_and_slide(velocity, Vector3.UP)
	
	if Input.is_action_pressed("shoot"):
		shoot()
	if Input.is_action_just_pressed("precision"):
		if precision == false:
			precision = true
			$Pivot/Camera.fov = 70
		else:
			precision = false
			$Pivot/Camera.fov = 90
			$Pivot.translation = pivot_position
	if precision:
		$Pivot.translation = lerp($Pivot.translation,pivot_position,0.1)
		$Pivot.translation.z = -1

func _input(event):
	if event is InputEventMouseMotion:
		if not precision:
			$Pivot.rotate_x(-event.relative.y * mouse_sensitivity)
			rotate_y(-event.relative.x * mouse_sensitivity)
			$Pivot.rotation.x = clamp($Pivot.rotation.x, -mouse_range, mouse_range)
		else:
			var new_pos = precision_sensitivity * Vector3(event.relative.x,-event.relative.y,0)
			var new_translation = $Pivot.translation + new_pos
			new_translation.x = clamp(new_translation.x,pivot_position.x-precision_range,pivot_position.x+precision_range) 
			new_translation.y = clamp(new_translation.y,pivot_position.y-precision_range,pivot_position.y+precision_range)
			$Pivot.translation = new_translation
			$Pivot/Camera/Crosshair.offset = Vector2(event.relative.x,-event.relative.y)

func get_input():
	var input_dir = Vector3.ZERO
	if Input.is_action_pressed("forward"):
		input_dir += -camera.global_transform.basis.z
	if Input.is_action_pressed("back"):
		input_dir += camera.global_transform.basis.z
	if Input.is_action_pressed("left"):
		input_dir += -camera.global_transform.basis.x
	if Input.is_action_pressed("right"):
		input_dir += camera.global_transform.basis.x
	input_dir = input_dir.normalized()
	return input_dir
	
func shoot():
	if not $Pivot/Flash.visible:
		$Pivot/Flash.show()
		$Pivot/Flash/Timer.start()
		if $Pivot/RayCast.is_colliding():
			var t = $Pivot/RayCast.get_collider()
			var p = $Pivot/RayCast.get_collision_point()
			var n = $Pivot/RayCast.get_collision_normal()
			var decal = Decal.instance()
			t.add_child(decal)
			decal.global_transform.origin = p
			decal.look_at(p + n, Vector3.UP)

	
func _on_Timer_timeout():
	$Pivot/Flash.hide()
