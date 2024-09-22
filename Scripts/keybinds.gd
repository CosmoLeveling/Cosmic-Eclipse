extends Control

@onready var input_button_scene = preload("res://Scenes/input_button.tscn")
@onready var action_list = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/ActionList

var paused: bool
var is_remapping = false
var action_to_remap
var remapping_button

var input_actions = {
	"up": "Move up",
	"left": "Move left",
	"down": "Move down",
	"right": "Move right",
	"shoot": "Shoot"
}

func _ready() -> void:
	_create_action_list()
	
func _create_action_list():
	InputMap.load_from_project_settings()
	for item in action_list.get_children():
		item.queue_free()
	
	for action in input_actions:
		var button = input_button_scene.instantiate()
		var action_label = button.find_child("LabelAction")
		var input_label = button.find_child("LabelInput")
		
		action_label.text = input_actions[action]
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			input_label.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			input_label.text = ""
		
		action_list.add_child(button)
		button.pressed.connect(_on_input_action_pressed.bind(button, action))
	
func _on_input_action_pressed(button, action):
	if !is_remapping:
		is_remapping=true
		action_to_remap = action
		remapping_button = button
		button.find_child("LabelInput").text = "Press key to bind..."
func _input(event: InputEvent) -> void:
	if is_remapping:
		if event is InputEventKey or event is InputEventMouseButton and event.pressed:
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap,event)
			_update_action_list(remapping_button, event)
			is_remapping = false
			action_to_remap = null
			remapping_button = null
		
func _update_action_list(button, event):
	button.find_child("LabelInput").text = event.as_text().trim_suffix(" (Phisical)")


func _on_back_pressed() -> void:
	Guis.find_child("Options_scene").visible = true
	visible = false


func _on_button_pressed() -> void:
	_create_action_list()
