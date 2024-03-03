extends CharacterBody2D

class_name zombie

@onready var sprite = $Sprite2D
@onready var ai = $AI
@export_group("motion")
@export var rotate_speed = 2
@export var walking = 2
@export var nav_pos = 2
@export var nav_target: Node2D
var health = 100

@export var speed = 90
# Called when the node enters the scene tree for the first time.
func _ready():
	ai.initilize(self)

func handle_hit():
	health -= 20
	print("enemy hit!", health)
	if health<= 0:
		queue_free()
