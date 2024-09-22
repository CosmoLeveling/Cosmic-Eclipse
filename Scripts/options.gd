extends Control
var paused:bool

func _on_back_pressed() -> void:
	if paused:
		Guis.find_child("pausescreen").visible = true
		paused = false
	visible = false


func _on_key_binds_pressed() -> void:
	Guis.find_child("Keybinds").visible = true
	visible = false
