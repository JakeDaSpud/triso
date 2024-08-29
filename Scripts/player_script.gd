extends Node3D

@export var _tile_size : int = 2;

var x : int;
var y : int;
var shape : String;
var Board : Array;

# Called when the node enters the scene tree for the first time.
func _ready():
	print_debug(x,", ",y)
	#var Board =  get_parent().Board

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print_debug(shape,", ",x,", ",y)
	# Handle Input
	if Input.is_action_just_pressed("Left") && Board[y][x-1] != "w" && Board[y][x-1] != "v":
		self.position.x -= _tile_size;
		x -= 1;
		print_debug(x,", ",y)
	
	if Input.is_action_just_pressed("Up") && Board[y-1][x] != "w" && Board[y-1][x] != "v":
		self.position.z -= _tile_size;
		y -= 1;
		print_debug(x,", ",y)
	
	if Input.is_action_just_pressed("Right") && Board[y][x+1] != "w" && Board[y][x+1] != "v":
		self.position.x += _tile_size;
		x += 1;
		print_debug(x,", ",y)
	
	if Input.is_action_just_pressed("Down") && Board[y+1][x] != "w" && Board[y+1][x] != "v":
		self.position.z += _tile_size;
		y += 1;
		print_debug(x,", ",y)
	
