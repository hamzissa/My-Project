extends CharacterBody2D

class_name Zombie

# Reference to the sprite and AI nodes
@onready var sprite = $Sprite2D
@onready var ai = $AI

# Reference to UI elements
@onready var health_bullet_ui: CanvasLayer = get_node("../health_bullet_UI") # Adjust the path according to your scene structure
@onready var score_label: Label = health_bullet_ui.get_node("VBoxContainer").get_node("bottom").get_node("VBoxContainer").get_node("score")

# Initial health and number of zombies to spawn
var health = 100
var number_of_zombies_to_spawn = 2

# Called when the node is ready
func _ready():
	# Initialize AI with self
	ai.initilize(self)

# Function to handle being hit
func handle_hit():
	# Decrease health and check if zombie should be destroyed
	health -= 100
	if health<= 0:
		queue_free()
		# Spawn new zombies if parent node exists
		var parent_node = get_parent()
		if parent_node != null:
			for i in range(number_of_zombies_to_spawn): 
				parent_node.spawn_zombie()
		# Update score label		
		score_label.text = str(int(score_label.text) + 1)
