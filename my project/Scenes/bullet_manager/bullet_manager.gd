extends Node2D
 
# Function to handle bullet spawning
func handle_bullet_spawned(bullet,position, direction):
	# Add the bullet as a child node
	add_child(bullet)
	# Set the global position and direction of the bullet
	bullet.global_position = position
	bullet.set_direction(direction)

