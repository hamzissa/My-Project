extends Node

#this will tell you whether the zombie is still, walking, running after the player or hitting the player

class_name ParentNode

var state
signal transitioned(state)
@export var initial: NodePath

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
