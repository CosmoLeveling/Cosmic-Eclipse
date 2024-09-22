@tool
extends Sprite2D
var anim_time:float
@export var anim_speed:float
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	anim_time += anim_speed
	if anim_time >= 49:
		anim_time = 0
	frame = anim_time
