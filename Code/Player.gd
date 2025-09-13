extends CharacterBody2D

const SPEED = 200  # швидкість пікселів за секунду

var BulletScene := preload("res://Scenes/Bullet.tscn")
@onready var gun = $Gun
@onready var muzzle = $Gun/Muzzle
@onready var crosshair = get_node("../CanvasLayer/Crosshair")
const MAGAZINE_SIZE := 10
var ammo := MAGAZINE_SIZE

func _ready():
	# Remap crouch to Command key on macOS
	if OS.get_name() == "macOS":
		InputMap.action_erase_events("ui_crouch")
		var cmd_event := InputEventKey.new()
		cmd_event.physical_keycode = Key.KEY_META
		InputMap.action_add_event("ui_crouch", cmd_event)

func _physics_process(delta):
	var direction = Vector2.ZERO
	
	# зчитуємо натискання клавіш
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	# нормалізуємо вектор, щоб не бігав швидше по діагоналі
	if direction != Vector2.ZERO:
		direction = direction.normalized()
	
	if Input.is_action_pressed("ui_sprint"):
		velocity = direction * SPEED * 2
	elif Input.is_action_pressed("ui_crouch"):
		velocity = direction * SPEED / 2
	else :
		velocity = direction * SPEED
	
	move_and_slide()

func _process(_delta):
	var mouse_pos = crosshair.global_position
	gun.look_at(mouse_pos)
	if Input.is_action_just_pressed("shoot"):
		if ammo > 0:
			var bullet = BulletScene.instantiate()
			bullet.global_position = muzzle.global_position
			bullet.direction = (crosshair.global_position - muzzle.global_position).normalized()
			bullet.rotation = bullet.direction.angle()
			get_tree().current_scene.add_child(bullet)
			ammo -= 1
	if Input.is_action_just_pressed("reload") and ammo < MAGAZINE_SIZE:
		ammo = MAGAZINE_SIZE
