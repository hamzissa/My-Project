extends CanvasLayer

class_name GameOver

@onready var main_menu =$CenterContainer/VBoxContainer/Main_menu as Button
@onready var quit =$CenterContainer/VBoxContainer/Quit as Button

# Called when the node enters the scene tree for the first time.
func _ready():
	main_menu.button_down.connect(on_main_menu)
	quit.button_down.connect(on_quit)

func on_main_menu() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu/menu.tscn")

func on_quit() -> void:
	get_tree().quit()
