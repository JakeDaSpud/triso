extends Node3D

@export var _tile_size : int = 2;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Handle Input
	if Input.is_action_just_pressed("Left"):
		self.position.x -= _tile_size;
	
	if Input.is_action_just_pressed("Up"):
		self.position.z -= _tile_size;
	
	if Input.is_action_just_pressed("Right"):
		self.position.x += _tile_size;
	
	if Input.is_action_just_pressed("Down"):
		self.position.z += _tile_size;
	
