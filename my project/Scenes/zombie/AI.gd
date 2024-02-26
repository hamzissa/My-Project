extends Node2D

class_name AI

@onready var player_detection_zone = $PlayerDetectionZone
@onready var current_state = State.PATROL : set = set_state
@onready var patrol_timer = $PatrolTimer

signal state_change(new_state) 

var player: player = null

# PATROL STATE 
var origin: Vector2 = Vector2.ZERO
var patrol_location: Vector2 = Vector2.ZERO
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
	emit_signal("state_chaged", current_state)
	
	
func _on_player_detection_zone_body_entered(body: Node) -> void:
	if body.is_in_group("player"): 
		set_state(State.ENGAGE)# Replace with function body.
		player = body	


func _on_patrol_timer_timeout():
	var patrol_range = 50
	var random_x = randi_range(-patrol_range, patrol_range) # Replace with function body.
	var random_y = randi_range(-patrol_range, patrol_range) # Replace with function body.
	patrol_location = Vector2(random_x,random_y) + origin
	patrol_location_reached = false
	actor_velocity = actor.global_position.direction_to(patrol_location) * 100
	
func _process(delta: float) -> void:
	match current_state:
		State.PATROL:
			if not (patrol_location_reached):
				actor.velocity = actor.global_position.direction_to(patrol_location) * 100
				actor.move_and_slide()
				patrol_timer.start()
				if actor.global_position.distance_to(patrol_location) < 5:
					patrol_location_reached = true
					actor_velocity = Vector2.ZERO
					patrol_timer.start()
				
func initilize(actor):
	self.actor = actor	
