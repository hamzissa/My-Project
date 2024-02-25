extends CharacterBody2D

class_name zombie
@onready var navigation_agent = $NavigationAgent2D
@onready var sprite = $Sprite2D
@export_group("motion")
@export var rotate_speed = 2
@export var walking = 2
@export var nav_pos = 2
@export var nav_target: Node2D


@export var speed = 90
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("set_target"):
		navigation_agent.target_position = get_global_mouse_position()
	update_nav()

func update_nav() -> void:
	if navigation_agent.is_navigation_finished() == false:
		var new_path: Vector2 = navigation_agent.get_next_path_position()
		sprite.look_at(new_path)
		velocity = global_position.direction_to(new_path) * speed
		move_and_slide() 

