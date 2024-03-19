extends Area2D

class_name HealthItem

func _on_body_entered(body):
	if body.is_in_group("player"): 
		queue_free()
		$"../Player"._on_health_item_health_collected()
