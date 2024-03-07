extends Control

class_name MainMenu

@onready var play_button = $MarginContainer/HBoxContainer/VBoxContainer/Play as Button
@onready var settings_button =$MarginContainer/HBoxContainer/VBoxContainer/Settings as Button
@onready var quit_button =$MarginContainer/HBoxContainer/VBoxContainer/Quit as Button
@onready var map = preload("res://Scenes/map/map.tscn") as PackedScene
@onready var settings_menu = $settings_menu as SettingsMenu
@onready var margin_container =$MarginContainer as MarginContainer

#func _on_start_button_pressed():
	#get_tree().change_scene_to_file(("res://Scenes/map/map.tscn"))

func _ready():
	handle_connection_of_signals()

func on_play() -> void:
	#get_tree().change_scene_to_file(("res://Scenes/map/map.tscn"))
	get_tree().change_scene_to_packed(map)

func on_settings() -> void:
	margin_container.visible = false
	settings_menu.set_process(true)
	settings_menu.visible = true

func on_quit() -> void:
	get_tree().quit()

func on_back_settings_menu() -> void:
	margin_container.visible = true
	settings_menu.visible = false

func handle_connection_of_signals() -> void:
	play_button.button_down.connect(on_play)
	settings_button.button_down.connect(on_settings)
	quit_button.button_down.connect(on_quit)
	settings_menu.exit_settings_menu.connect(on_back_settings_menu)
