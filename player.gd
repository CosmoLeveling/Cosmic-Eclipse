extends CharacterBody2D

@onready var bolt = preload("res://Bolt.tscn")
@onready var ammo: Label = $"../CanvasLayer/Gui/HBoxContainer/Label2"
@onready var health_bar: ProgressBar = $"../CanvasLayer/Gui/ProgressBar"
const SPEED = 133.0
const JUMP_VELOCITY = -400.0
var current_ammo = 10
var max_ammo = 10
var cooldown_ability_1 = 0
@onready var health_component: HealthComponent = $HealthComponent

func _process(delta: float) -> void:
	health_bar.max_value = health_component.max_health
	ammo.text = str(current_ammo) + "/" + str(max_ammo)
	health_bar.value = health_component.health

func _physics_process(delta: float) -> void:
	
	look_at(get_global_mouse_position())
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("left", "right","up","down")
	velocity.x = direction.x*SPEED
	velocity.y = direction.y*SPEED
	move_and_slide()

func _ammo_pickup(num):
	current_ammo += num
	current_ammo = clamp(current_ammo,0,max_ammo)
func _kill():
	position = Vector2(0,0)
	health_component.health = health_component.max_health
	current_ammo = max_ammo
	
