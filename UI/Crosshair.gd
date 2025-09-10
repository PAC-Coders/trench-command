extends Sprite2D

var sensitivity := 1.0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	global_position = get_viewport_rect().size / 2

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		global_position += event.relative * sensitivity
		var rect := get_viewport_rect()
		global_position.x = clamp(global_position.x, rect.position.x, rect.position.x + rect.size.x)
		global_position.y = clamp(global_position.y, rect.position.y, rect.position.y + rect.size.y)

func set_sensitivity(value: float) -> void:
	sensitivity = value
