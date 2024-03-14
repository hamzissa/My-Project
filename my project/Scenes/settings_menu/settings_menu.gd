extends Control

class_name SettingsMenu
#back button declared as variable
@onready var back_button = $MarginContainer/VBoxContainer/back as Button

signal exit_settings_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	#when started backbutton is connected and when pressed it goes back to menu
	back_button.button_down.connect(on_back_button)
	set_process(false) 

#when back button is pressed sends signal to menu
func on_back_button() -> void:
	exit_settings_menu.emit()
	set_process(false) 
