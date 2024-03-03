extends CharacterBody2D



class_name player
#speed of player and mouse speed
const speed: float = 130.0
const mouse_speed = 5
@export var bullet :PackedScene
@onready var end_of_gun = $EndOfGun
@onready var gun_direction = $gun_direction

signal player_fired_bullet(bullet,position, direction)

#direction mouse is pointing towards
var mouse_direct
var health = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#calling function to allow the movment of the sprite
	get_input()
	#function to move
	move_and_slide()
	
	#to make player face in direction of mouse
	if mouse_direct:
		global_rotation = lerp_angle(global_rotation, mouse_direct, delta*mouse_speed)

func get_input() -> void:
	#playermovement WASD 
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = input.normalized() * speed
	#direction of mouse
	mouse_direct = (get_global_mouse_position() - global_position).angle()

func _unhandled_input(event):
	if event.is_action_pressed("shoot"):
		printerr("click")
		shoot()
	
	
func shoot():
	var bullet_instance = bullet.instantiate()
	#add_child(bullet_instance)
	printerr("shoot")
	#bullet_instance.global_position = end_of_gun.global_position
	#var target = get_global_mouse_position()
	#var direction_to_mouse = end_of_gun.global_position.direction_to(target).normalized()
	#bullet_instance.set_direction(direction_to_mouse)
	var direction = (gun_direction.global_position - end_of_gun.global_position).normalized()
	emit_signal("player_fired_bullet", bullet_instance, end_of_gun.global_position,direction)

func handle_hit():
	health -= 20
	print("player hit!", health)
