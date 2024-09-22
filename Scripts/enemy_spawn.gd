extends Marker2D
@onready var enemy = preload("res://Scenes/Enemy.tscn")
@export var player: CharacterBody2D
@export var radius = 100

func _on_timer_timeout() -> void:
	var enemy_to_spawn = enemy.instantiate()
	var x_point = randi_range(0,radius)
	
	enemy_to_spawn.position.x = player.position.x + x_point
	enemy_to_spawn.position.y = player.position.y + (radius-x_point)
	enemy_to_spawn.player = player
	
	get_parent().get_parent().add_child(enemy_to_spawn)
