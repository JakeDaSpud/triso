extends Node3D

@export var _tile_size : int = 2;

var x : int;
var y : int;
var shape : String;
var far : int;
var Board : Array[Array];
var BoardEmpty : Array[Array];
var GotEmpty = false;
var count = 0;
var timer : int;

@export var onGoalTile : bool = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Get board array from parent, change current coordinates with own shape, update the parent's board
	Board = get_parent().Board;
	Board[y][x] = shape;
	get_parent().Board = Board
	# Only once get the empty board from the parent, this will not change
	if !GotEmpty:
		BoardEmpty = get_parent().BoardEmpty;
		GotEmpty = true;
	# Add a vary short timer that stops similtanious imputs from breaking the movement array
	timer += 1;
	
	# Handle Input
	if Input.is_action_just_pressed("Left") && timer > 2:
		# Use variable far in cases where the immediate next space is filled by a player, but somewhere down the line is free so everyone can move and this player should
		timer = 0;
		far = x-1;
		while true:
			# Stop at walls or voids
			if Board[y][far] == "w" || Board[y][far] == "v":
				break;
			
			# If moving into a player check if there is a free space after so everyone can move
			elif Board[y][far] == "s" || Board[y][far] == "c" || Board[y][far] == "t":
				far -= 1;
			
			# Move if free space available
			else:
				self.position.x -= _tile_size;
				# Change current tile to be the ground tile under the player
				Board[y][x] = BoardEmpty[y][x];
				x -= 1;
				print(shape,": ",x,",",y)
				break;
			
		Board = get_parent().Board;
		checkIfOnGoal();
	
	if Input.is_action_just_pressed("Up") && timer > 2:
		timer = 0;
		far = y-1;
		while true:
			if Board[far][x] == "w" || Board[far][x] == "v":
				break;
			
			elif Board[far][x] == "s" || Board[far][x] == "c" || Board[far][x] == "t":
				far -= 1;
			
			else:
				self.position.z -= _tile_size;
				Board[y][x] = BoardEmpty[y][x];
				y -= 1;
				print(shape,": ",x,",",y)
				break;
			
		Board = get_parent().Board;
		checkIfOnGoal();
	
	if Input.is_action_just_pressed("Right") && timer > 2:
		timer = 0;
		far = x+1;
		while true:
			if Board[y][far] == "w" || Board[y][far] == "v":
				break;
			
			elif Board[y][far] == "s" || Board[y][far] == "c" || Board[y][far] == "t":
				far += 1;
			
			else:
				self.position.x += _tile_size;
				Board[y][x] = BoardEmpty[y][x];
				x += 1;
				print(shape,": ",x,",",y)
				break;
			
		Board = get_parent().Board;
		checkIfOnGoal();
	
	if Input.is_action_just_pressed("Down") && timer > 2:
		timer = 0;
		far = y+1;
		while true:
			if Board[far][x] == "w" || Board[far][x] == "v":
				break;
			
			elif Board[far][x] == "s" || Board[far][x] == "c" || Board[far][x] == "t":
				far += 1;
			
			else:
				self.position.z += _tile_size;
				Board[y][x] = BoardEmpty[y][x];
				y += 1;
				print(shape,": ",x,",",y)
				break;
			
		Board = get_parent().Board;
		checkIfOnGoal();
	
	if Input.is_action_just_pressed("ui_accept"):
		count += 1;
		print("\nBoard ", count)
		for inner_array in Board:
			print(inner_array, inner_array.size());
	

func checkIfOnGoal():
	if BoardEmpty[y][x] == "x" && self.shape == "c":
		self.onGoalTile = true;
		
	elif BoardEmpty[y][x] == "y" && self.shape == "s":
		self.onGoalTile = true;
	
	elif BoardEmpty[y][x] == "z" && self.shape == "t":
		self.onGoalTile = true;
	
	else:
		self.onGoalTile = false;
	
