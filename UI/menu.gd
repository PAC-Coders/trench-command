# res://UI/menu.gd   (attach to the ROOT Control of your Menu scene)
extends Control

const GAME_SCENE_PATH := "res://Scenes/Game.tscn"

var play_btn: Button
var quit_btn: Button

func _ready() -> void:
	# Locate buttons (works even if your paths/layout differ)
	play_btn = _find_button(["CenterContainer/VBoxContainer/Play", "VBoxContainer/Play", "Play"], "Play")
	quit_btn = _find_button(["CenterContainer/VBoxContainer/Quit", "VBoxContainer/Quit", "Quit"], "Quit")

	# Wire signals + ensure they can receive keyboard focus
	if play_btn:
		play_btn.focus_mode = Control.FOCUS_ALL
		play_btn.pressed.connect(_on_play_pressed)
	else:
		push_error("Menu.gd: Could not find a Play button.")

	if quit_btn:
		quit_btn.focus_mode = Control.FOCUS_ALL
		quit_btn.pressed.connect(_on_quit_pressed)
	else:
		push_warning("Menu.gd: Could not find a Quit button.")

	# Explicit focus neighbors (arrow keys / d-pad navigation)
	if play_btn and quit_btn:
		play_btn.focus_neighbor_bottom = play_btn.get_path_to(quit_btn)
		quit_btn.focus_neighbor_top    = quit_btn.get_path_to(play_btn)
		# Tab order (optional, for Tab/Shift+Tab)
		play_btn.focus_next      = play_btn.get_path_to(quit_btn)
		quit_btn.focus_previous  = quit_btn.get_path_to(play_btn)

	# Give initial focus to Play after one frame (so Enter works immediately)
	if play_btn:
		await get_tree().process_frame
		play_btn.grab_focus()

func _on_play_pressed() -> void:
	if not ResourceLoader.exists(GAME_SCENE_PATH):
		push_error("Menu.gd: Target scene missing: " + GAME_SCENE_PATH)
		return
	get_tree().change_scene_to_file(GAME_SCENE_PATH)

func _on_quit_pressed() -> void:
	get_tree().quit()

# --- Optional: “belt-and-suspenders” keyboard handling ---
# Keeps Enter-to-Play and Esc-to-Quit even if focus is lost,
# and toggles focus with Up/Down if neighbors ever fail.
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and quit_btn:
		_on_quit_pressed()
	elif event.is_action_pressed("ui_accept") and play_btn:
		# If nothing focused, treat Enter as Play
		if get_viewport().gui_get_focus_owner() == null:
			_on_play_pressed()
	elif play_btn and quit_btn:
		if event.is_action_pressed("ui_down"):
			var f = get_viewport().gui_get_focus_owner()
			if f == play_btn: quit_btn.grab_focus()
			elif f == null:   play_btn.grab_focus()
		elif event.is_action_pressed("ui_up"):
			var f2 = get_viewport().gui_get_focus_owner()
			if f2 == quit_btn: play_btn.grab_focus()
			elif f2 == null:   play_btn.grab_focus()

# --- helpers ---

func _find_button(candidates: Array, name_hint: String) -> Button:
	# 1) exact node paths (if your scene matches these)
	for p in candidates:
		var n := get_node_or_null(p)
		if n is Button:
			return n

	# 2) unique-name shorthand (tick "Unique Name in Scene" on the Button)
	var unique := get_node_or_null("%" + name_hint)
	if unique is Button:
		return unique

	# 3) recursive search by node name
	var by_name := find_child(name_hint, true, false)
	if by_name is Button:
		return by_name

	# 4) recursive search by button text
	var by_text := _find_button_by_text(name_hint)
	if by_text:
		return by_text

	return null

func _find_button_by_text(text: String) -> Button:
	var stack: Array = [self]
	var target := text.strip_edges().to_lower()
	while stack.size() > 0:
		var node: Node = stack.pop_back()
		if node is Button:
			var b := node as Button
			if b.text.strip_edges().to_lower() == target:
				return b
		for c in node.get_children():
			stack.push_back(c)
	return null
