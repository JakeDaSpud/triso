extends Node3D

@export var _tile_size : int = 2;

var x : int;
var y : int;
var shape : String;
var far : int;
var Board : Array;
var BoardEmpty : Array;
var GotEmpty = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var Board = get_parent().Board;
	if !GotEmpty:
		BoardEmpty = get_parent().BoardEmpty;
		GotEmpty = true;
	
	# Handle Input
	if Input.is_action_just_pressed("Left"):
		Board[y][x] = shape;
		far = x-1;
		while true:
			if Board[y][far] == "w" || Board[y][far] == "v":
				break;
			
			elif Board[y][far] == "s" || Board[y][far] == "c" || Board[y][far] == "t":
				far -= 1;
			
			else:
				self.position.x -= _tile_size;
				Board[y][x] = BoardEmpty[y][x];
				Board[y][x-1] = shape;
				x -= 1;
				print_debug(x,", ",y)
				get_parent().Board = Board
				break;
	
	if Input.is_action_just_pressed("Up"):
		Board[y][x] = shape;
		far = y-1;
		while true:
			if Board[far][x] == "w" || Board[far][x] == "v":
				break;
			
			elif Board[far][x] == "s" || Board[far][x] == "c" || Board[far][x] == "t":
				far -= 1;
			
			else:
				self.position.z -= _tile_size;
				Board[y][x] = BoardEmpty[y][x];
				Board[y-1][x] = shape;
				y -= 1;
				print_debug(x,", ",y)
				get_parent().Board = Board
				break;
	
	if Input.is_action_just_pressed("Right"):
		Board[y][x] = shape;
		far = x+1;
		while true:
			if Board[y][far] == "w" || Board[y][far] == "v":
				break;
			
			elif Board[y][far] == "s" || Board[y][far] == "c" || Board[y][far] == "t":
				far += 1;
			
			else:
				self.position.x += _tile_size;
				Board[y][x] = BoardEmpty[y][x];
				Board[y][x+1] = shape;
				x += 1;
				print_debug(x,", ",y)
				get_parent().Board = Board
				break;
	
	if Input.is_action_just_pressed("Down"):
		Board[y][x] = shape;
		far = y+1;
		while true:
			if Board[far][x] == "w" || Board[far][x] == "v":
				break;
			
			elif Board[far][x] == "s" || Board[far][x] == "c" || Board[far][x] == "t":
				far += 1;
			
			else:
				self.position.z += _tile_size;
				Board[y][x] = BoardEmpty[y][x];
				Board[y+1][x] = shape;
				y += 1;
				print_debug(x,", ",y)
				get_parent().Board = Board
				break;
	
