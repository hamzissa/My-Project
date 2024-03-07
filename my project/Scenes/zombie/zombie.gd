extends CharacterBody2D

class_name Zombie

@onready var sprite = $Sprite2D
@onready var ai = $AI

@export_group("motion")
@export var rotate_speed = 2
@export var walking = 2
@export var nav_pos = 2
@export var nav_target: Node2D
@export var speed = 90

var health = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	ai.initilize(self)

func handle_hit():
	health -= 20
	print("enemy hit!", health)
	if health<= 0:
		queue_free()
