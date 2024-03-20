extends Area2D

class_name HealthItem

# Function called when another body enters the area
func _on_body_entered(body):
	# Check if the body is in the player group
	if body.is_in_group("player"): 
		# Free the health item from memory
		queue_free()
		# Call the _on_health_item_health_collected method on the Player node
		$"../Player"._on_health_item_health_collected()
