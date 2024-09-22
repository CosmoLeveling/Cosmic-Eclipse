class_name HitBox
extends Area2D

@export var health_component : HealthComponent
@export var is_player = false

func damage(Attack:attack):
	if health_component:
		health_component.damage(Attack)
