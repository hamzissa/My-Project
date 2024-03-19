extends CanvasLayer

func _ready():
	get_tree().paused=true

func _on_resume_pressed():
	get_tree().paused = false
	queue_free()

func _on_quit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/menu/menu.tscn")
