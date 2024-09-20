extends CharacterBody2D

@onready var bolt = preload("res://Bolt.tscn")
var current_ammo = 10
var max_ammo = 10
var cooldown_ability_1 = 0

func _process(delta: float) -> void:
	if cooldown_ability_1 == 0:
		if Input.is_action_pressed("shoot"):
			if true:
				shoot()
	else:
		cooldown_ability_1 -= 1

func shoot():
	current_ammo -= 1
	cooldown_ability_1 = 100
	var bullet = bolt.instantiate()
	get_parent().get_parent().add_child(bullet)
	bullet.rotation = global_rotation
	bullet.position = $FirePosition.global_position
