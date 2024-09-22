extends TileMapLayer

@onready var sprite = preload("res://sprite_2d.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse = get_local_mouse_position()
	
		
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if get_cell_source_id(local_to_map(mouse)) == 0 or not (get_cell_source_id(local_to_map(mouse)+Vector2i(1,0)) == 0 or get_cell_source_id(local_to_map(mouse)+Vector2i(-1,0)) == 0 or get_cell_source_id(local_to_map(mouse)+Vector2i(0,-1)) == 0 or get_cell_source_id(local_to_map(mouse)+Vector2i(0,1)) == 0 ):
			return
		var block = sprite.instantiate()
		block.position = map_to_local(local_to_map(mouse))
		set_cell(local_to_map(mouse),0,Vector2(0,0))
