extends Area2D

class_name Bullet

# Export variable for bullet speed
@export var speed = 10
# Reference to the kill timer node
@onready var kill_timer = $KillTimer
# Initialise direction vector
var direction = Vector2.ZERO

# Function called when the node is ready
func _ready():
	# Start the kill timer
	kill_timer.start()

# Function called during each physics update	
func _physics_process(delta: float) -> void:
	# Move the bullet according to its direction and speed
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		global_position += velocity

# Function to set the direction of the bullet
func set_direction(direction: Vector2):
	# Set the direction and update rotation 
	self.direction = direction
	rotation += direction.angle()

# Function called when the kill timer times out
func _on_kill_timer_timeout():
	# Free the bullet from memory
	queue_free()

# Function called when another body enters the area
func _on_body_entered(body):
	# Check if the body has a method to handle the hit
	if body.has_method("handle_hit"):
		# Call the handle_hit method on the body
		body.handle_hit()
	# Free the bullet from memory	
	queue_free()
