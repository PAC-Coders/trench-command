extends CharacterBody2D

const SPEED = 200  # швидкість пікселів за секунду

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
	if Input.is_action_pressed("ui_crouch"):
		velocity = direction * SPEED / 2
	else :
		velocity = direction * SPEED
	
	move_and_slide()
