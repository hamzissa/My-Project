extends Node2D

@onready var bulletManager =$BulletManager
@onready var player = $bullet_manager

var pause_scene: PackedScene = preload("res://Scenes/paused_menu/pause_screen.tscn")
var ai_scene: PackedScene = preload("res://Scenes/zombie/zombie.tscn")
var spawn_area = Rect2(500, 500, 1000, 1000) # Define the area where AI can spawn

func _ready() -> void:
	randomize();
	$Player.connect("player_fired_bullet", bulletManager.handle_bullet_spawned,1)
	#player.player_fired_bullet.connect("player_fired_bullet", bulletManager,"handle_bullet_spawned") 
	for i in range(10): spawn_ai()
	
func spawn_ai():
	var random_position = Vector2(
		randf_range(spawn_area.position.x, spawn_area.position.x + spawn_area.size.x),
		randf_range(spawn_area.position.y, spawn_area.position.y + spawn_area.size.y)
	)
	var ai_instance = ai_scene.instantiate()
	add_child(ai_instance)
	ai_instance.global_position = random_position

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		var pause_menu = pause_scene.instantiate()
		add_child(pause_menu)
		
		#var pause_menu = paused_scene.instantiate()
		#add_child(pause_menu)
		#var current_value : bool = get_tree().paused
		#get_tree().paused = !current_value
