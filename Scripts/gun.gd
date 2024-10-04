extends CharacterBody2D

@onready var bolt = preload("res://Scenes/Bolt.tscn")
var cooldown_ability_1 = 0
@export var Player:player
func _process(delta: float) -> void:
	if Player != null:
		if cooldown_ability_1 == 0:
			if Input.is_action_pressed("shoot"):
				if Player.current_energy > 0:
					shoot()
		else:
			cooldown_ability_1 -= 1

func shoot():
	Player.current_energy -= 1
	cooldown_ability_1 = 75
	var bullet = bolt.instantiate()
	get_parent().get_parent().add_child(bullet)
	bullet.rotation = global_rotation
	bullet.position = $FirePosition.global_position
