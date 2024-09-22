extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_back_pressed() -> void:
	get_tree().paused = false
	visible = false


func _on_options_pressed() -> void:
	Guis.find_child("Options_scene").paused = true
	Guis.find_child("Options_scene").visible = true
	visible = false
