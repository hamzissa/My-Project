extends Node2D

class_name AI

# Declare variables for player detection zones and patrol timer
@onready var player_detection_zone = $PlayerDetectionZone
@onready var player_detection_touch_zone = $PlayerDetectionTouchZone
@onready var patrol_timer = $PatrolTimer

# Initialise current state to PATROL and declare health related UI elements
@onready var current_state = State.PATROL : set = set_state
@onready var health_bullet_ui: CanvasLayer = get_node("../../health_bullet_UI") 
@onready var health_bar: ProgressBar = health_bullet_ui.get_node("VBoxContainer").get_node("top").get_node("health_bar")

# Define signal for state change
signal state_change(new_state) 

# Declare variables for player, zombie, origin, patrol location, and other attributes
var player: Player = null
var zombie: CharacterBody2D = null
var origin: Vector2 = Vector2.ZERO
var patrol_location: Vector2 = Vector2(600,600)
var patrol_location_reached : bool = false
var zombie_velocity: Vector2 = Vector2.ZERO
var engaged_zombie = preload("res://assets/images/zombie_standing.png")
var game_over: PackedScene = preload("res://Scenes/game_over/game_over.tscn")

# Define Zombie states
enum State {
	PATROL,
	ENGAGE
}

# Function to set the state of Zombie
func set_state(new_state: int) :
	if (new_state) == current_state:
		return

	if new_state == State.PATROL:
		# Initialise origin and start the patrol timer
		origin = zombie.global_position
		patrol_timer.start()
		patrol_location_reached = true
		
	current_state = new_state
	emit_signal("state_changed", current_state)

# Function called when player enters the detection zone
func _on_player_detection_zone_body_entered(body: Node) -> void:
	if body.is_in_group("player"): 
		# Switch to ENGAGE state if player detected
		set_state(State.ENGAGE)
		player = body	

# Function called when player enters the touch detection zone
func _player_detection_touch_zone_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		# Decrease health and play sound when player touches the zombie
		health_bar.value = float(int(health_bar.value) - 10)
		$"../AudioStreamPlayer2D".play()
		if health_bar.value == 0:
			# Instantiate game over scene if health is zero
			var game_over_end = game_over.instantiate()
			add_child(game_over_end)

# Function called when the patrol timer times out
func _on_patrol_timer_timeout():
	var patrol_range_min = 600
	var patrol_range_max = 2100
	var random_x = randi_range(patrol_range_min, patrol_range_max) 
	var random_y = randi_range(patrol_range_min, patrol_range_max) 
	patrol_location = Vector2(random_x,random_y) + origin
	patrol_location_reached = false
	zombie_velocity = zombie.global_position.direction_to(patrol_location) * 100

# Function called during each physics update
func _physics_process(delta: float) -> void:
	match current_state:
		State.PATROL:
			if not (patrol_location_reached):	
				# Move towards patrol location if not reached yet
				zombie.velocity = zombie.global_position.direction_to(patrol_location) * 100
				var collision = zombie.move_and_slide()
				if collision:
					# Get a new patrol location if collision occurs
					_on_patrol_timer_timeout()
				if zombie.global_position.distance_to(patrol_location) < 5:
					# Mark patrol location as reached
					patrol_location_reached = true
					zombie_velocity = Vector2.ZERO
					patrol_timer.start()
				if zombie.velocity.length_squared() > 0:
					# Update rotation if moving
					zombie.rotation = zombie.velocity.angle()	
			else:
				# Trigger a new patrol timer if patrol location reached
				_on_patrol_timer_timeout()		
				patrol_location_reached = false
		State.ENGAGE:	
			if player != null:
				# Move towards the player if engaged
				var direction_to_player = zombie.global_position.direction_to(player.global_position)
				# Set the velocity to move towards the player
				var velocity_multiplier = 100
				zombie.velocity = direction_to_player * velocity_multiplier
				# Move the zombie towards the player
				zombie.move_and_slide()
				# Update the rotation of the zombie to face the player
				zombie.rotation = direction_to_player.angle()
				# Change sprite to indicate chasing
				$"../Sprite2D".texture = ResourceLoader.load("res://assets/images/zombie_chasing.png")
		_:
			# Handle invalid state
			printerr("Error: state is invalid for Zombie")		

# Function to initialize the zombie
func initilize(zombie):
	self.zombie = zombie	
