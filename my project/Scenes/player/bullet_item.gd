extends Area2D

class_name BulletItem

# Function called when another body enters the area
func _on_body_entered(body):
	# Check if the body is in the player group
	if body.is_in_group("player"): 
		# Free the bullet item from memory
		queue_free()
		# Call the _on_bullet_item_bullet_collected method on the Player node
		$"../Player"._on_bullet_item_bullet_collected()
