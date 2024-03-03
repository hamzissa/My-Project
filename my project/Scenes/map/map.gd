extends Node2D

var ai_scene: PackedScene = preload("res://Scenes/zombie/zombie.tscn")
var spawn_area = Rect2(500, 500, 1000, 1000) # Define the area where AI can spawn
@onready var bullet_manager =$bullet_manager
@onready var player = $bullet_manager
func _ready() -> void:
	randomize();
	$player.connect("player_fired_bullet", bullet_manager.handle_bullet_spawned,1)
	#player.player_fired_bullet.connect("player_fired_bullet", bullet_manager,"handle_bullet_spawned") 
	for i in range(10): spawn_ai()
	
	
func spawn_ai():
	var random_position = Vector2(
		randf_range(spawn_area.position.x, spawn_area.position.x + spawn_area.size.x),
		randf_range(spawn_area.position.y, spawn_area.position.y + spawn_area.size.y)
	)
	var ai_instance = ai_scene.instantiate()
	add_child(ai_instance)
	ai_instance.global_position = random_position
