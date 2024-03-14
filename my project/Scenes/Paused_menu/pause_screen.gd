extends CanvasLayer



#@onready var Resume_button = $CenterContainer/VBoxContainer/Resume as Button
#@onready var quit_button = $CenterContainer/VBoxContainer/Quit as Button

# when started it stays on the main screen
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

#when resume is pressed it brings you back to the game
func _on_resume_pressed():
	get_tree().paused = false
	queue_free()

#when quit is pressed it takes you to the menu
func _on_quit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/menu/menu.tscn")
