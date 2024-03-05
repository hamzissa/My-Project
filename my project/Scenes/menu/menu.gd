extends Control

class_name MainMenu

@onready var play_button = $MarginContainer/HBoxContainer/VBoxContainer/Play as Button
@onready var settings_button =$MarginContainer/HBoxContainer/VBoxContainer/Settings as Button
@onready var quit_button =$MarginContainer/HBoxContainer/VBoxContainer/Quit as Button
@onready var map = preload("res://Scenes/map/map.tscn") as PackedScene
#func _on_start_button_pressed():
	#get_tree().change_scene_to_file(("res://Scenes/map/map.tscn"))

func _ready():
	play_button.button_down.connect(on_play)
	quit_button.button_down.connect(on_exit)

func on_play() -> void:
	#get_tree().change_scene_to_file(("res://Scenes/map/map.tscn"))
	get_tree().change_scene_to_packed(map)
func on_exit() -> void:
	get_tree().quit()
