extends Node

@onready var pause_menu = $"../CanvasLayer/PauseMenu"
@onready var crosshair = $"../CanvasLayer/Crosshair"

var game_paused: bool = false

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		game_paused = not game_paused
		
	if game_paused == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		crosshair.hide()
		get_tree().paused = true
		pause_menu.show()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		crosshair.show()
		get_tree().paused = false
		pause_menu.hide()

func _on_resume_pressed() -> void:
	game_paused = not game_paused
	if game_paused == true :
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		crosshair.hide()
		get_tree().paused = true
		pause_menu.show()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		crosshair.show()
		get_tree().paused = false
		pause_menu.hide()
