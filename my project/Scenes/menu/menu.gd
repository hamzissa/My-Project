extends Control

class_name MainMenu

# References to UI elements and scenes
@onready var play_button = $MarginContainer/HBoxContainer/VBoxContainer/Play as Button
@onready var settings_button =$MarginContainer/HBoxContainer/VBoxContainer/Settings as Button
@onready var quit_button =$MarginContainer/HBoxContainer/VBoxContainer/Quit as Button
@onready var map = preload("res://Scenes/map/map.tscn") as PackedScene
@onready var settings_menu = $settings_menu as SettingsMenu
@onready var margin_container =$MarginContainer as MarginContainer

# Function called when the node is ready
func _ready():
	# Connect UI signals
	handle_connection_of_signals()

# Function to handle play button press
func on_play() -> void:
	# Change scene to the map scene
	get_tree().change_scene_to_packed(map)

# Function to handle settings button press
func on_settings() -> void:
	# Toggle visibility of UI elements for settings menu
	margin_container.visible = false
	settings_menu.set_process(true)
	settings_menu.visible = true

# Function to handle quit button press
func on_quit() -> void:
	# Quit the game
	get_tree().quit()

# Function to handle back button press in settings menu
func on_back_settings_menu() -> void:
	# Toggle visibility of UI elements for main menu and settings menu
	margin_container.visible = true
	settings_menu.visible = false

# Function to connect UI signals
func handle_connection_of_signals() -> void:
	# Connect button signals to their functions
	play_button.button_down.connect(on_play)
	settings_button.button_down.connect(on_settings)
	quit_button.button_down.connect(on_quit)
	settings_menu.exit_settings_menu.connect(on_back_settings_menu)
