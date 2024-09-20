class_name enemy
extends CharacterBody2D
@onready var Ammo_scene = preload("res://ammo.tscn")
@export var player:CharacterBody2D
var cooldown = 0
var attacking = null
var is_attacking = false
func _process(delta: float) -> void:
	if is_attacking and cooldown <= 0:
		var Attack = attack.new()
		Attack.attack_damage = 1
		attacking.damage(Attack)
		cooldown = 50
	else:
		cooldown -= 1

func _physics_process(delta: float) -> void:
	velocity.y = sin(rotation)*50
	velocity.x = cos(rotation)*50
	look_at(player.global_position)
	move_and_slide()
func _kill():
	var Ammo = Ammo_scene.instantiate()
	Ammo.Ammo = randi_range(5,10)
	Ammo.position = position
	get_parent().add_child(Ammo)
	queue_free()





func _on_attacker_area_entered(area: Area2D) -> void:
	if area is HitBox and area.is_player == true:
		is_attacking = true
		attacking = area

func _on_attacker_area_exited(area: Area2D) -> void:
	if area is HitBox and area.is_player == true:
		is_attacking = false
		attacking = null
