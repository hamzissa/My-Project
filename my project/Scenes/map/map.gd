extends Node2D

@onready var bulletManager = $BulletManager
@onready var excluded_area: Polygon2D = $NavigationZone/Island
#@onready var spawn_area: NavigationRegion2D = $NavigationZone

var pause_scene: PackedScene = preload("res://Scenes/paused_menu/pause_screen.tscn")
var ai_scene: PackedScene = preload("res://Scenes/zombie/zombie.tscn")
var spawn_area = Rect2(450, 450, 1100, 1100) 


var number_of_zombies_at_start = 10
var bullet_pickup_instance = null
var health_pickup_instance = null

func _ready() -> void:
	randomize();
	$Player.connect("player_fired_bullet", bulletManager.handle_bullet_spawned,1)
	#player.player_fired_bullet.connect("player_fired_bullet", bulletManager,"handle_bullet_spawned") 
	for i in range(number_of_zombies_at_start): spawn_ai()
	

func is_position_inside_excluded_area(position: Vector2, excluded_area: Polygon2D) -> bool:
	# Get the polygon points
	var points = excluded_area.get_polygon()

	# Perform a point-in-polygon test
	var inside = false
	var j = points.size() - 1
	for i in range(points.size()):
		if (points[i].y > position.y) != (points[j].y > position.y) && position.x < (points[j].x - points[i].x) * (position.y - points[i].y) / (points[j].y - points[i].y) + points[i].x:
			inside = !inside
		j = i
	return inside

func spawn_ai():
	while true:
		var random_position = Vector2(
			randf_range(spawn_area.position.x, spawn_area.position.x + spawn_area.size.x),
			randf_range(spawn_area.position.y, spawn_area.position.y + spawn_area.size.y)
		)

		# Check if the random position is inside the excluded area
		if not is_position_inside_excluded_area(random_position, excluded_area):
			var ai_instance = ai_scene.instantiate()
			add_child(ai_instance)
			ai_instance.global_position = random_position
			break  # Exit the loop if a suitable position is found

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		var pause_menu = pause_scene.instantiate()
		add_child(pause_menu)
		
		#var pause_menu = paused_scene.instantiate()
		#add_child(pause_menu)
		#var current_value : bool = get_tree().paused
		#get_tree().paused = !current_value
		
func spawn_bullet_pickup():
	var bullet_pickup_scene = preload("res://Scenes/player/bullet_item.tscn")

	# Generate random position within your game area
	var random_position = Vector2(
			randf_range(spawn_area.position.x, spawn_area.position.x + spawn_area.size.x),
			randf_range(spawn_area.position.y, spawn_area.position.y + spawn_area.size.y)
	)

	if not is_position_inside_excluded_area(random_position, excluded_area):
		# Create an instance of the bullet pickup scene at the random position
		if bullet_pickup_instance != null and bullet_pickup_instance.is_visible_in_tree():
			bullet_pickup_instance.queue_free()  # Remove the bullet pickup instance if it's no longer visible
			bullet_pickup_instance = null  # Reset bullet_pickup_instance
		bullet_pickup_instance = bullet_pickup_scene.instantiate()
		bullet_pickup_instance.global_position = random_position
		add_child(bullet_pickup_instance)		

func spawn_health_pickup():
	var health_pickup_scene = preload("res://Scenes/player/health_item.tscn")

	# Generate random position within your game area
	var random_position = Vector2(
			randf_range(spawn_area.position.x, spawn_area.position.x + spawn_area.size.x),
			randf_range(spawn_area.position.y, spawn_area.position.y + spawn_area.size.y)
	)

	if not is_position_inside_excluded_area(random_position, excluded_area):
		# Create an instance of the bullet pickup scene at the random position
		if health_pickup_instance != null and health_pickup_instance.is_visible_in_tree():
			health_pickup_instance.queue_free()  # Remove the bullet pickup instance if it's no longer visible
			health_pickup_instance = null  # Reset bullet_pickup_instance
		health_pickup_instance = health_pickup_scene.instantiate()
		health_pickup_instance.global_position = random_position
		add_child(health_pickup_instance)	
