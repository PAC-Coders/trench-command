extends CanvasLayer

func _ready():
	visible = true
	if not has_node("Panel/Label"):
		var panel := Panel.new(); add_child(panel)
		panel.name = "Panel"; panel.size = Vector2(260, 40)
		var label := Label.new(); panel.add_child(label)
		label.name = "Label"
		panel.position = Vector2(10, 10)

func _input(event):
	if event.is_action_pressed("toggle_dev_hud"):
		visible = not visible

func _process(delta: float) -> void:
	@warning_ignore("narrowing_conversion")
	var fps: int = Engine.get_frames_per_second()
	var ms: int = snapped(delta * 1000.0, 0.1)
	$Panel/Label.text = "FPS: %s | Frame: %sms" % [str(fps), str(ms)]
