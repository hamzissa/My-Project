extends CanvasLayer

# Function called when the node is ready
func _ready():
	# Pause the game when the node is ready
	get_tree().paused=true

# Function called when resume button is pressed
func _on_resume_pressed():
	# Unpause the game and free the node
	get_tree().paused = false
	queue_free()

# Function called when quit button is pressed
func _on_quit_pressed():
	# Unpause the game and change scene to the main menu
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/menu/menu.tscn")
