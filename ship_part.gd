extends Node2D
class_name ShipPart
@export var left = true
@export var up = true
@export var right = true
@export var down = true

var next_rotation_left: bool
var next_rotation_up: bool
var next_rotation_right: bool
var next_rotation_down: bool

#TRUTH TABLES
# 1010 rotate once 0101 rotate again 1010
# 1000 rotate once 0100 rotate again 0010 rotate again 0001
# 1110 rotate once 0111 rotate again 1011 rotate again 1101
# 1100 rotate once 0110 rotate again 0011 rotate again 1001
#
#

func _ready() -> void:
	refresh_next()

func refresh_next():
	next_rotation_left = down
	next_rotation_down = right
	next_rotation_right = up
	next_rotation_up = left

func rot():
	get_parent().rotate(deg_to_rad(90))
	print(left)
	refresh_next()
	left = next_rotation_left
	up = next_rotation_up
	right = next_rotation_right
	down = next_rotation_down
	refresh_next()
	print(left)
	
