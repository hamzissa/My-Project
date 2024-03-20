extends CanvasLayer

class_name GameOver

# Reference to the main menu and quit buttons
@onready var main_menu =$CenterContainer/VBoxContainer/Main_menu as Button
@onready var quit =$CenterContainer/VBoxContainer/Quit as Button

# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect button signals to their respective functions
	main_menu.button_down.connect(on_main_menu)
	quit.button_down.connect(on_quit)

# Function to handle main menu button press
func on_main_menu() -> void:
	# Change the scene to the main menu
	get_tree().change_scene_to_file("res://Scenes/menu/menu.tscn")

# Function to handle quit button press
func on_quit() -> void:
	# Quit the game
	get_tree().quit()
