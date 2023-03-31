extends KinematicBody

onready var camera = $Pivot/Camera
onready var Decal = load("res://Player/Decal.tscn")

var speed = 5
var gravity = -8.0
var direction = Vector3()
var mouse_sensitivity = 0.001
var mouse_range = 1.2
var velocity = Vector2.ZERO


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Pivot/Camera.current = true

func _physics_process(_delta):
	velocity = get_input()*speed
	velocity.y += gravity
	if is_on_floor():
		velocity.y = 0

	if velocity != Vector3.ZERO:
		velocity = move_and_slide(velocity, Vector3.UP)
	
	if Input.is_action_pressed("shoot"):
		shoot()

func _input(event):
	if event is InputEventMouseMotion:
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -mouse_range, mouse_range)

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
