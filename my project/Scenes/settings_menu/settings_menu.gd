extends Control

class_name SettingsMenu

# Reference to the back button
@onready var back_button = $MarginContainer/VBoxContainer/back as Button

# Signal emitted when the settings menu is exited
signal exit_settings_menu

# Called when the node is ready
func _ready():
	# Connect the back button signal
	back_button.button_down.connect(on_back_button)
	# Connect the back button signal
	set_process(false) 

func _process(delta):
	pass

# Function to handle the back button press
func on_back_button() -> void:
	# Emit the signal to exit the settings menu
	exit_settings_menu.emit()
	# Disable processing for this node
	set_process(false) 
