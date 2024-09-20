class_name HealthComponent
extends Node2D

@export var max_health := 10
var health : float

func _ready() -> void:
	health = max_health
	
func damage(Attack:attack):
	health -= Attack.attack_damage
	
	if health <= 0:
		$".."._kill()
