extends CanvasLayer
var player: Node

func _ready():
	player = get_tree().current_scene.get_node_or_null("Player")
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
	if not player:
		player = get_tree().current_scene.get_node_or_null("Player")

	var ammo_text := ""
	if player:
		var ammo: int = player.ammo
		ammo_text = " | Ammo: %s/%s" % [str(ammo), str(player.MAGAZINE_SIZE)]
	$Panel/Label.text = "FPS: %s | Frame: %sms%s" % [str(fps), str(ms), ammo_text]
