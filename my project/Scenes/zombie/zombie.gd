extends CharacterBody2D

class_name Zombie

@onready var sprite = $Sprite2D
@onready var ai = $AI
@onready var health_bullet_ui: CanvasLayer = get_node("../health_bullet_UI") # Adjust the path according to your scene structure
@onready var score_label: Label = health_bullet_ui.get_node("VBoxContainer").get_node("bottom").get_node("score")

var health = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	ai.initilize(self)

func handle_hit():
	health -= 33.9
	print("enemy hit!", health)
	if health<= 0:
		queue_free()
		score_label.text = str(int(score_label.text) + 1)
