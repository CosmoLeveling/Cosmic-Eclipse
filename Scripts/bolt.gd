extends Node2D
@export var hit_particle : PackedScene
@onready var timer: Timer = $Timer
@export var piercing = 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y +=sin(rotation)
	position.x +=cos(rotation)
	if piercing <=0:
		print("dead")
		var _particle = hit_particle.instantiate()
		_particle.position = global_position
		_particle.rotation = global_rotation
		_particle.emitting = true
		queue_free()
		get_tree().current_scene.add_child(_particle)

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is HitBox:
		if area.has_method("damage"):
			piercing -= 1
			var Attack = attack.new()
			Attack.attack_damage = 1
			area.damage(Attack)
			var _particle = hit_particle.instantiate()
			_particle.position = global_position
			_particle.rotation = global_rotation
			_particle.emitting = true
			get_tree().current_scene.add_child(_particle)


func _on_timer_timeout() -> void:
	var _particle = hit_particle.instantiate()
	_particle.position = global_position
	_particle.rotation = global_rotation
	_particle.emitting = true
	queue_free()


func _on_hitbox_body_entered(body: Node2D) -> void:
	if not body is enemy :
		piercing = 0
