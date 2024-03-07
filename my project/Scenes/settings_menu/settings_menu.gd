extends Control

class_name SettingsMenu

@onready var back_button = $MarginContainer/VBoxContainer/back as Button

signal exit_settings_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	back_button.button_down.connect(on_back_button)
	set_process(false) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_back_button() -> void:
	exit_settings_menu.emit()
	set_process(false) 
