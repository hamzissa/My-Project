extends Control

class_name SettingsMenu

@onready var back_button = $MarginContainer/VBoxContainer/back as Button

signal exit_settings_menu

func _ready():
	back_button.button_down.connect(on_back_button)
	set_process(false) 

func _process(delta):
	pass

func on_back_button() -> void:
	exit_settings_menu.emit()
	set_process(false) 
