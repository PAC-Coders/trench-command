extends CharacterBody2D

const SPEED = 200  # швидкість пікселів за секунду

var BulletScene := preload("res://Scenes/Bullet.tscn")
@onready var gun = $Gun
@onready var muzzle = $Gun/Muzzle

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
	var mouse_pos = get_global_mouse_position()
	gun.look_at(mouse_pos)
