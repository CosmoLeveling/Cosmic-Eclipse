extends TileMapLayer

var ship_grid : Dictionary

@export var main: CharacterBody2D

var able_build:bool

var rot = 0
var part_id = 1

@export var trans: Sprite2D

var checks = [Vector2i(1,0),Vector2i(-1,0),Vector2i(0,1),Vector2i(0,-1)]
var checks2 = [Vector2i(2,0),Vector2i(-2,0),Vector2i(0,2),Vector2i(0,-2),Vector2i(1,1),Vector2i(-1,-1),Vector2i(-1,1),Vector2i(1,-1)]

@onready var core = preload("res://Scenes/Part/Core.tscn")
@onready var spike = preload("res://Scenes/Part/Spike.tscn")

func bfs(start_node:CharacterBody2D, target_node:CharacterBody2D):
	var queue = []
	var visited: Dictionary

	queue.append(start_node)
	visited[start_node] = true

	while not queue.is_empty():
		var current_node = queue.pop_front()
		
		if current_node == target_node:
			return true  # Zielknoten gefunden
		for neighbor in get_neighbors(current_node):
			if not visited.has(neighbor):
				queue.append(neighbor)
				visited[neighbor] = true
	return false  # Zielknoten nicht gefunden

func get_neighbors(current_node:CharacterBody2D):
	var neighbors:Dictionary
	if get_part(current_node.global_position+Vector2(16,0)) is CharacterBody2D and get_part(current_node.global_position+Vector2(16,0)).find_child("ShipPart").right == true and current_node.find_child("ShipPart").left:
		var local = get_part(current_node.global_position+Vector2(16,0))
		neighbors[local] = local.global_position
	if get_part(current_node.global_position+Vector2(-16,0)) is CharacterBody2D and get_part(current_node.global_position+Vector2(-16,0)).find_child("ShipPart").left == true and current_node.find_child("ShipPart").right:
		var local = get_part(current_node.global_position+Vector2(-16,0))
		neighbors[local] = local.global_position
	if get_part(current_node.global_position+Vector2(0,-16)) is CharacterBody2D and get_part(current_node.global_position+Vector2(0,-16)).find_child("ShipPart").up == true and current_node.find_child("ShipPart").down:
		var local = get_part(current_node.global_position+Vector2(0,-16))
		neighbors[local] = local.global_position
	if get_part(current_node.global_position+Vector2(0,16)) is CharacterBody2D and get_part(current_node.global_position+Vector2(0,16)).find_child("ShipPart").down == true and current_node.find_child("ShipPart").up:
		var local = get_part(current_node.global_position+Vector2(0,16))
		neighbors[local] = local.global_position
	return neighbors

func add_part(coords : Vector2, part : CharacterBody2D) -> void:
	ship_grid[coords] = part

func get_part(coords : Vector2):
	if ship_grid.has(coords) == false:
		return
	return ship_grid.get(coords)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_part(main.global_position, main)
	pass # Replace with function body.

func remove_part(part:CharacterBody2D):
	if part is CharacterBody2D and not part == main:
		ship_grid.erase(part.global_position)
		part.queue_free()

func place_part(new_part):
	var mouse = get_local_mouse_position()
	new_part.position = map_to_local(local_to_map(mouse))-Vector2(8,8)
	get_parent().add_child(new_part)
	add_part(new_part.position,new_part)

func breaking(mouse):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		remove_part(get_part(map_to_local(local_to_map(mouse))-Vector2(8,8)))

func confirm():
	var buildable = true
	for w in ship_grid.values():
		if bfs(w,main) == false:
			buildable = false
	print(buildable)

func bld(mouse,new_part):
	for shippart in ship_grid.keys():
		if get_part(shippart) is CharacterBody2D:
			breaking(mouse)
			if get_part(map_to_local(local_to_map(mouse))-Vector2(8,8)) is CharacterBody2D:
				able_build = false
				return
			if local_to_map(get_part(shippart).position) == local_to_map(mouse):
				able_build = false
				if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
					return
			if local_to_map(get_part(shippart).position) == local_to_map(mouse)+ Vector2i(1,0):
				if get_part(shippart) is CharacterBody2D and get_part(shippart).find_child("ShipPart").right == true and new_part.find_child("ShipPart").left:
					able_build = true
					if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
						place_part(new_part)
					return
			elif local_to_map(get_part(shippart).position) == local_to_map(mouse)+ Vector2i(-1,0):
				if get_part(shippart) is CharacterBody2D and get_part(shippart).find_child("ShipPart").left == true and new_part.find_child("ShipPart").right:
					able_build = true
					if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
						place_part(new_part)
					return
			elif local_to_map(get_part(shippart).position) == local_to_map(mouse)+ Vector2i(0,1):
				if get_part(shippart) is CharacterBody2D and get_part(shippart).find_child("ShipPart").down == true and new_part.find_child("ShipPart").up:
					able_build = true
					if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
						place_part(new_part)
					return
			elif local_to_map(get_part(shippart).position) == local_to_map(mouse)+ Vector2i(0,-1):
				if get_part(shippart) is CharacterBody2D and get_part(shippart).find_child("ShipPart").up == true and new_part.find_child("ShipPart").down:
					able_build = true
					if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
						place_part(new_part)
					return
			else:
				able_build = false

func build(mouse):
	if part_id == 3:
		trans.texture = preload("res://Assets/Textures/Parts/facingun.png")
		var new_part = preload("res://Scenes/Part/gun.tscn").instantiate()
		new_part.find_child("ShipPart").left = rot == 2
		new_part.find_child("ShipPart").up = rot == 3
		new_part.find_child("ShipPart").right = rot == 0
		new_part.find_child("ShipPart").down = rot == 1
		if rot == 0:
			new_part.find_child("Sprite2D").rotation = deg_to_rad(90)
		if rot == 1:
			new_part.find_child("Sprite2D").rotation = deg_to_rad(180)
		if rot == 2:
			new_part.find_child("Sprite2D").rotation = deg_to_rad(270)
		if rot == 3:
			new_part.find_child("Sprite2D").rotation = deg_to_rad(0)
		bld(mouse,new_part)
	if part_id == 2:
		trans.texture = preload("res://Assets/Textures/Parts/Spike.png")
		var new_part = spike.instantiate()
		new_part.find_child("ShipPart").left = rot == 0
		new_part.find_child("ShipPart").up = rot == 1
		new_part.find_child("ShipPart").right = rot == 2
		new_part.find_child("ShipPart").down = rot == 3
		if rot == 0:
			new_part.find_child("Sprite2D").rotation = deg_to_rad(90)
		if rot == 1:
			new_part.find_child("Sprite2D").rotation = deg_to_rad(180)
		if rot == 2:
			new_part.find_child("Sprite2D").rotation = deg_to_rad(270)
		if rot == 3:
			new_part.find_child("Sprite2D").rotation = deg_to_rad(0)
		bld(mouse,new_part)
	if part_id == 1:
		trans.texture = preload("res://Assets/Textures/Parts/Core.png")
		var new_part = core.instantiate()
		bld(mouse,new_part)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	trans.material.set_shader_parameter("buildable",able_build)
	if Input.is_action_just_pressed("rotate"):
		rot += 1
	if rot == 4:
		rot = 0
	var mouse = get_local_mouse_position()
	trans.position = map_to_local(local_to_map(mouse))-Vector2(8,8)
	trans.rotation = deg_to_rad((rot+1)*90) 
	build(mouse)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if get_part(map_to_local(local_to_map(mouse))) is CharacterBody2D:
			return
		


func _on_button_pressed() -> void:
	confirm()

func _on_item_list_item_selected(index: int) -> void:
	part_id=index+1
