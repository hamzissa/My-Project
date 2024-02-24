extends CharacterBody2D

const speed: float = 130.0
const mouse_speed = 5

var mouse_direct

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	get_input()
	move_and_slide()
	
	if mouse_direct:
		global_rotation = lerp_angle(global_rotation, mouse_direct, delta*mouse_speed)
func get_input() -> void:
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = input.normalized() * speed
	mouse_direct = (get_global_mouse_position() - global_position).angle()


