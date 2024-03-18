extends CanvasLayer

class_name GameOver

@onready var main_menu =$CenterContainer/VBoxContainer/Main_menu as Button
@onready var quit =$CenterContainer/VBoxContainer/Quit as Button

#@onready var health_bullet_ui: CanvasLayer = get_node("res://Scenes/health_bullet_UI/") # Adjust the path according to your scene structure
#@onready var score_label: Label = health_bullet_ui.get_node("VBoxContainer").get_node("bottom").get_node("VBoxContainer").get_node("score")
# Called when the node enters the scene tree for the first time.
func _ready():
	main_menu.button_down.connect(on_main_menu)
	quit.button_down.connect(on_quit)

func on_main_menu() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu/menu.tscn")


func on_quit() -> void:
	get_tree().quit()

#func label() -> void:
	#$CenterContainer/VBoxContainer/score.text = str(int(score_label.text))
