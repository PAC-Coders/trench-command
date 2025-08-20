extends Control

@onready var play_btn := $VBoxContainer/Play
@onready var quit_btn := $VBoxContainer/Quit

func _ready():
	play_btn.pressed.connect(_on_play)
	quit_btn.pressed.connect(get_tree().quit)
	play_btn.grab_focus()

func _on_play():
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
