extends Node2D

class_name AI

@onready var player_detection_zone = $PlayerDetectionZone
@onready var current_state = State.PATROL : set = set_state
@onready var patrol_timer = $PatrolTimer

signal state_change(new_state) 

var player: player = null

# PATROL STATE 
var origin: Vector2 = Vector2.ZERO
var patrol_location: Vector2 = Vector2(600,600)
var actor: CharacterBody2D = null
var patrol_location_reached : bool = false
var actor_velocity: Vector2 = Vector2.ZERO

enum State {
	PATROL,
	ENGAGE
}

func set_state(new_state: int) :
	if (new_state) == current_state:
		return
	
	if new_state == State.PATROL:
		origin = actor.global_position
		patrol_timer.start()
		patrol_location_reached = true
		
	current_state = new_state
	emit_signal("state_changed", current_state)
	
	
func _on_player_detection_zone_body_entered(body: Node) -> void:
	if body.is_in_group("player"): 
		set_state(State.ENGAGE)# Replace with function body.
		player = body	


func _on_patrol_timer_timeout():
	printerr("test")
	var patrol_range_min = 600
	var patrol_range_max = 2100
	var random_x = randi_range(patrol_range_min, patrol_range_max) # Replace with function body.
	var random_y = randi_range(patrol_range_min, patrol_range_max) # Replace with function body.
	patrol_location = Vector2(random_x,random_y) + origin
	patrol_location_reached = false
	actor_velocity = actor.global_position.direction_to(patrol_location) * 100
	
func _physics_process(delta: float) -> void:
	match current_state:
		State.PATROL:
			printerr("1")
			if not (patrol_location_reached):	
				printerr(patrol_location)
				actor.velocity = actor.global_position.direction_to(patrol_location) * 100
				var collision = actor.move_and_slide()
				if collision:
					# Collision occurred, get a new patrol location
					_on_patrol_timer_timeout()
				#patrol_timer.start()
				if actor.global_position.distance_to(patrol_location) < 5:
					printerr("3")
					patrol_location_reached = true
					actor_velocity = Vector2.ZERO
					patrol_timer.start()
			else:
				_on_patrol_timer_timeout()		
				patrol_location_reached = false
				
func initilize(actor):
	self.actor = actor	
