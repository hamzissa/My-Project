extends CharacterBody2D

class_name Player

const SPEED: float = 130.0 #speed of player and mouse speed
const MOUSE_SPEED = 5

@export var bullet :PackedScene

@onready var end_of_gun = $EndOfGun
@onready var gun_direction = $GunDirection
@onready var attack_cooldown = $AttackCooldown
@onready var annimation_player = $AnimationPlayer
@onready var health_bullet_ui: CanvasLayer = get_node("../health_bullet_UI") # Adjust the path according to your scene structure
@onready var health_bar: ProgressBar = health_bullet_ui.get_node("VBoxContainer").get_node("top").get_node("health_bar")
@onready var current_ammo_label: Label = health_bullet_ui.get_node("VBoxContainer").get_node("bottom").get_node("current_ammo")


signal player_fired_bullet(bullet,position, direction)
signal weapon_no_ammo

var max_ammo: int = 100
var current_ammo: int = max_ammo
var crosshair = preload("res://assets 2/images/crosshair_white-export.png") #crosshair
var mouse_direct #direction mouse is pointing towards
var health = 100
var stats: PackedScene = preload("res://Scenes/health_bullet_UI/health_bullet_count.tscn")
var spawn_timer: float = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_custom_mouse_cursor(crosshair)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#calling function to allow the movment of the sprite
	get_input()
	#function to move
	move_and_slide()
	
	var parent_node = get_parent()
	if parent_node != null:
		spawn_timer -= delta
		if spawn_timer <= 0:
			parent_node.spawn_bullet_pickup()
			parent_node.spawn_health_pickup()
			spawn_timer = 30
			

	#to make player face in direction of mouse
	if mouse_direct:
		global_rotation = lerp_angle(global_rotation, mouse_direct, delta*MOUSE_SPEED)
		

func get_input() -> void:
	#playermovement WASD 
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = input.normalized() * SPEED
	#direction of mouse
	mouse_direct = (get_global_mouse_position() - global_position).angle()

func _unhandled_input(event):
	if event.is_action_pressed("shoot"):
		printerr("click")
		shoot()
	if event.is_action_pressed("reload"):
		print("reload")
		reload()

func reload():
	current_ammo = max_ammo
	printerr("\n reload \n ")

func shoot():
	if current_ammo != 0 && attack_cooldown.is_stopped():
		var bullet_instance = bullet.instantiate()
		#add_child(bullet_instance)
		printerr("shoot")
		#bullet_instance.global_position = end_of_gun.global_position
		#var target = get_global_mouse_position()
		#var direction_to_mouse = end_of_gun.global_position.direction_to(target).normalized()
		#bullet_instance.set_direction(direction_to_mouse)
		var direction = (gun_direction.global_position - end_of_gun.global_position).normalized()
		emit_signal("player_fired_bullet", bullet_instance, end_of_gun.global_position,direction)
		current_ammo -= 1
		current_ammo_label.text = str(current_ammo)
		attack_cooldown.start()
		annimation_player.play("muzzle_flash")
		if current_ammo == 0:
			emit_signal("weapon_no_ammo")
				

func handle_hit():
	health -= 20
	print("player hit!", health)
	

func _on_bullet_item_bullet_collected():
	current_ammo = max_ammo
	current_ammo_label.text = str(current_ammo)
	print("Bullet collected!")
	
func _on_health_item_health_collected():
	health = 100
	health_bar.value = float(int(100))
	print("Health collected!")	
