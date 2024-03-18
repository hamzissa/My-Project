extends CharacterBody2D

class_name Zombie

@onready var sprite = $Sprite2D
@onready var ai = $AI
@onready var health_bullet_ui: CanvasLayer = get_node("../health_bullet_UI") # Adjust the path according to your scene structure
@onready var score_label: Label = health_bullet_ui.get_node("VBoxContainer").get_node("bottom").get_node("VBoxContainer").get_node("score")

#@onready var game_over_ui: CanvasLayer = get_node("../game_over") 
#@onready var score_label2: Label = game_over_ui.get_node("CenterContainer").get_node("VBoxContainer").get_node("score")

var health = 100
var number_of_zombies_to_spawn = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	ai.initilize(self)

func handle_hit():
	health -= 100
	print("enemy hit!", health)
	if health<= 0:
		queue_free()
		var parent_node = get_parent()
		if parent_node != null:
			for i in range(number_of_zombies_to_spawn): 
				parent_node.spawn_ai()
		score_label.text = str(int(score_label.text) + 1)
