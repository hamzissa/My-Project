extends CanvasLayer
class_name paused_menu


#@onready var Resume_button = $CenterContainer/VBoxContainer/Resume as Button
#@onready var quit_button = $CenterContainer/VBoxContainer/Quit as Button
# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused=true
	#Resume_button.button_down.connect(on_resume)
	#quit_button.button_down.connect(on_exit)

#func on_resume() -> void:
	#get_tree().paused=false
	#Resume_button.button_down.connect(on_resume)


#func on_exit() -> void:
	#get_tree().paused=false
	#get_tree().change_scene_to_file("res://Scenes/menu/menu.tscn")




func _on_resume_pressed():
	get_tree().paused = false
	queue_free()


func _on_quit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/menu/menu.tscn")
