class_name player
extends CharacterBody2D

@onready var bolt = preload("res://Scenes/Bolt.tscn")
@onready var ammo: Label = $"../CanvasLayer/Gui/HBoxContainer/Label2"
@onready var health_bar: ProgressBar = $"../CanvasLayer/Gui/ProgressBar"
const SPEED = 133.0
const JUMP_VELOCITY = -400.0
var current_energy = 10
var max_energy = 10
var cooldown_ability_1 = 0
var cores = []
var rotati: Vector2
@onready var health_component: HealthComponent = $HealthComponent

func _ready() -> void:
	_update_max_energy()
	current_energy = max_energy

func _update_max_energy():
	for ch in get_children():
		if ch is Core:
			cores.append(ch.energy_max_increase)
	max_energy = 10
	for c in cores:
		max_energy += c

func _process(delta: float) -> void:
	
	Guis.find_child("Gui").find_child("Health").max_value = health_component.max_health
	Guis.find_child("Gui").find_child("Box").find_child("Energy").text = str(current_energy) + "/" + str(max_energy)
	Guis.find_child("Gui").find_child("Health").value = health_component.health

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("left", "right","up","down")
	velocity.x = direction.x*SPEED
	velocity.y = direction.y*SPEED
	move_and_slide()

func _ammo_pickup(num):
	current_energy += num
	current_energy = clamp(current_energy,0,max_energy)
func _kill():
	position = Vector2(0,0)
	health_component.health = health_component.max_health
	current_energy = max_energy
	
