extends CanvasLayer

const PANEL_MARGIN := Vector2(10, 10)
const PANEL_SIZE := Vector2(260, 40)
const LABEL_PADDING := Vector2(8, 8)

var player: Node = null

@onready var panel: Panel = _ensure_panel()
@onready var label: Label = _ensure_label()

func _ready() -> void:
		visible = true
		_refresh_player_reference()
		_configure_panel()
		_configure_label()
		_update_text()

func _process(_delta: float) -> void:
		if not player or not player.is_inside_tree():
				_refresh_player_reference()
		_update_text()

func _refresh_player_reference() -> void:
		var active_scene := get_tree().current_scene
		player = active_scene.get_node_or_null("Player") if active_scene else null

func _ensure_panel() -> Panel:
		var existing_panel := get_node_or_null("Panel")
		if existing_panel:
				return existing_panel as Panel
		var new_panel := Panel.new()
		new_panel.name = "Panel"
		add_child(new_panel)
		return new_panel

func _ensure_label() -> Label:
		if panel.has_node("Label"):
				return panel.get_node("Label") as Label
		var new_label := Label.new()
		new_label.name = "Label"
		panel.add_child(new_label)
		return new_label

func _configure_panel() -> void:
		panel.set_anchors_preset(Control.PRESET_TOP_RIGHT, true)
		panel.offset_right = -PANEL_MARGIN.x
		panel.offset_left = panel.offset_right - PANEL_SIZE.x
		panel.offset_top = PANEL_MARGIN.y
		panel.offset_bottom = panel.offset_top + PANEL_SIZE.y
		panel.custom_minimum_size = PANEL_SIZE
		panel.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _configure_label() -> void:
		label.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		label.offset_left = LABEL_PADDING.x
		label.offset_right = -LABEL_PADDING.x
		label.offset_top = LABEL_PADDING.y
		label.offset_bottom = -LABEL_PADDING.y
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER

func _update_text() -> void:
		if label == null:
				return
		var ammo_text := "Ammo: --/--"
		if player:
				ammo_text = "Ammo: %s/%s" % [str(player.ammo), str(player.MAGAZINE_SIZE)]
		label.text = ammo_text
