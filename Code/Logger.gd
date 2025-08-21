extends Node

var log_file_path : String
var file : FileAccess

func _ready() -> void:
	# Шлях до папки logs
	var logs_dir = "user://logs"
	DirAccess.make_dir_recursive_absolute(logs_dir)
	
	# Ім'я файлу: session_2025-08-21_00-45-12.jsonl
	var timestamp = Time.get_datetime_string_from_system(true, true).replace(":", "-")
	log_file_path = logs_dir + "/session_" + timestamp + ".jsonl"
	
	file = FileAccess.open(log_file_path, FileAccess.WRITE)
	if file:
		log_event("session_start", {"time": Time.get_unix_time_from_system()})
	else:
		push_error("Unable to open log file: " + log_file_path)


func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST or what == NOTIFICATION_PREDELETE:
		if file:
			log_event("session_end", {"time": Time.get_unix_time_from_system()})
			file.close()


func log_event(event_type: String, data: Dictionary = {}):
	if not file:
		return
	var entry = {
		"event": event_type,
		"data": data,
		"ts": Time.get_unix_time_from_system()
	}
	file.store_line(JSON.stringify(entry))
	file.flush()
