extends CharacterBody2D

class_name Zombie

@onready var sprite = $Sprite2D
@onready var ai = $AI



var health = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	ai.initilize(self)

func handle_hit():
	health -= 33.9
	print("enemy hit!", health)
	if health<= 0:
		queue_free()
