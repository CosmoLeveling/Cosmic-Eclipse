extends Control

@onready var player = $"../../Player"
@onready var ammo_counter = $HBoxContainer/Label2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ammo_counter.text = str(player.current_ammo)+"/"+str(player.max_ammo)
