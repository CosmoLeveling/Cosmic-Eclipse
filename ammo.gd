class_name Collectible
extends Area2D

@export var Ammo: int = 5




func _on_body_entered(body: Node2D) -> void:
	if body.has_method("_ammo_pickup"):
		body._ammo_pickup(Ammo)
		queue_free()
	if body.get_parent().has_method("_ammo_pickup"):
		body.get_parent()._ammo_pickup(Ammo)
		queue_free()
