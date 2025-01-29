extends Node3D

var GAMEMANAGERS_TileSize : float = 2.0;

# Create an array of arrays to store x and y positions of all tiles that players can access
var Board : Array[Array];
# Create an array of arrays to see map without players on it
var BoardEmpty : Array[Array];

# All Entities that can be Instanced
const Circle_Player_Entity = preload("res://Entities/Players/Circle.tscn");
const Square_Player_Entity = preload("res://Entities/Players/Square.tscn");
const Triangle_Player_Entity = preload("res://Entities/Players/Triangle.tscn");
const Spawn_Entity = preload("res://Entities/Tiles/Spawn_Tile.tscn");
var Players : Array[Node3D] = [];

const Circle_Goal_Entity = preload("res://Entities/Tiles/CircleGoal_Tile.tscn");
const Square_Goal_Entity = preload("res://Entities/Tiles/SquareGoal_Tile.tscn");
const Triangle_Goal_Entity = preload("res://Entities/Tiles/TriangleGoal_Tile.tscn");

const Ground_Entity = preload("res://Entities/Tiles/Ground_Tile.tscn");
const Wall_Entity = preload("res://Entities/Tiles/Wall_Tile.tscn");
#const Void_Entity = null;

enum TileType {
	CIRCLE,
	SQUARE,
	TRIANGLE,
	SPAWN,
	
	CIRCLE_GOAL,
	SQUARE_GOAL,
	TRIANGLE_GOAL,
	
	GROUND,
	WALL,
	VOID
}

# Map Stats
var tile_count : int = 0;
var with_void_tile_count : int = 0;
var map_length : int = 0;
var map_height : int = 0;
var tile_queue : Array = [];

# Entity Stats
var circle_player_count : int = 0;
var square_player_count : int = 0;
var triangle_player_count : int = 0;
var spawn_count : int = 0;

var circle_goal_count : int = 0;
var square_goal_count : int = 0;
var triangle_goal_count : int = 0;

var ground_count : int = 0;
var wall_count : int = 0;
var void_count : int = 0;

func _ready():
	# Add first row to array
	Board.append([]);
	
	load_level();
	
	# Remove last empty row that is created because of level file structure
	Board.remove_at(Board.size() - 1);
	#print_debug("Board ", Board.size())
	for inner_array in Board:
		#print_debug(inner_array, inner_array.size());
		# Fill the empty board with duplicate rows from the main board array
		BoardEmpty.append(inner_array.duplicate());
	# Replace all the players in the empty board with ground tiles
	for row  in range(0,BoardEmpty.size()-1):
		for tile in range(0,BoardEmpty[row].size()):
			if BoardEmpty[row][tile] == "s" || BoardEmpty[row][tile] == "c" || BoardEmpty[row][tile] == "t":
				BoardEmpty[row][tile] = "g";
	#print_debug("Board Empty ", BoardEmpty.size())
	for inner_array in BoardEmpty:
		print_debug(inner_array, inner_array.size());
	

func _load_from_file(_file_path : String) -> String:
	var _file = FileAccess.open(_file_path, FileAccess.READ);
	var _file_content = _file.get_as_text();
	return _file_content;
	

func load_level(level_file_path : String = GameManager.level_to_load) -> void:
	# Text / ASCII Raw Data of the Level
	var _level_file = _load_from_file(level_file_path);
	#print_debug("Raw Level.txt:");
	#print_debug(_level_file);
	
	var _tile_pos = Vector3(0, 0, 0);
	
	# Break File Level String into each tile by the ',' delimiter
	var _lines = _level_file.split(",");
	
	# Empty check
	if (_lines.is_empty()):
		print_debug("Level File has no data");
		return;
	
	print_debug(_lines);
	
	# iterate col
	var col = 0;
	var row = 0;
	var _index = 0;
	
	for _current_tile : String in _lines:
		_current_tile = _current_tile.replace(" ", "");
		
		#print_debug("Current Tile at [", col, ", ", row, "]:", _current_tile);
		
		# End parsing
		if (_current_tile == null):
			print_debug("Null Current Tile???");
		
		# Go down a row
		elif (_current_tile.contains("\n")):
			var _tile_duo = _current_tile.split('\n');
			
			#print("Duo 0: ", _tile_duo[0]);
			#print("Duo 1: ", _tile_duo[1]);
			
			# Last tile on the current line
			_determine_tile_and_spawn(_tile_duo[0], Vector3(col * GAMEMANAGERS_TileSize, 0, row * GAMEMANAGERS_TileSize));
			# Add character to the last array inside the board array
			Board.back().append(_tile_duo[0]);
			
			#print_debug("Going to next line!");
			col = 0;
			row += 1;
			# start new line in array
			Board.append([]);
			
			# First tile on the next line
			_determine_tile_and_spawn(_tile_duo[1], Vector3(col * GAMEMANAGERS_TileSize, 0, row * GAMEMANAGERS_TileSize));
			# Add character to the last array inside the board array
			Board.back().append(_tile_duo[1]);
			
			# Add new row to array ever line in the text file
		
		# Going right
		else:
			col += 1;
		
		_determine_tile_and_spawn(_current_tile, Vector3(col * GAMEMANAGERS_TileSize, 0, row * GAMEMANAGERS_TileSize));
		if(_current_tile != "v\nv"):
			# Add character to the last array inside the board array
			Board.back().append(_current_tile);
	# 
	

func _determine_tile_and_spawn(_current_tile : String, _tile_pos : Vector3):
	_current_tile.strip_edges();
	
	if (_current_tile == "c"):
		_spawn(_tile_pos, Spawn_Entity);
		spawn_count += 1;
		_spawn(_tile_pos, Circle_Player_Entity);
		circle_player_count += 1;
	
	elif (_current_tile == "s"):
		_spawn(_tile_pos, Spawn_Entity);
		spawn_count += 1;
		_spawn(_tile_pos, Square_Player_Entity);
		square_player_count += 1;
	
	elif (_current_tile == "t"):
		_spawn(_tile_pos, Spawn_Entity);
		spawn_count += 1;
		_spawn(_tile_pos, Triangle_Player_Entity);
		triangle_player_count += 1;
	
	elif (_current_tile == "x"):
		_spawn(_tile_pos, Circle_Goal_Entity);
		circle_goal_count += 1;
	
	elif (_current_tile == "y"):
		_spawn(_tile_pos, Square_Goal_Entity);
		square_goal_count += 1;
	
	elif (_current_tile == "z"):
		_spawn(_tile_pos, Triangle_Goal_Entity);
		triangle_goal_count += 1;
	
	elif (_current_tile == "g"):
		_spawn(_tile_pos, Ground_Entity);
		ground_count += 1;
	
	elif (_current_tile == "w"):
		_spawn(_tile_pos, Wall_Entity);
		wall_count += 1;
	
	elif (_current_tile == "v"):
		void_count += 1;
	
	else:
		print_debug("Invalid Level Character: '", _current_tile + "'");
		tile_count -= 1;
	
	tile_count += 1;
	with_void_tile_count = tile_count + void_count;

func _spawn(pos : Vector3, type : PackedScene) -> void:
	var _tile = type.instantiate();
	
	_tile.position = pos;
	
	# If the created tile is a player then add x and y position, aswell as tell it what type of shape it is
	if type == Circle_Player_Entity || type == Square_Player_Entity || type == Triangle_Player_Entity:
		_tile.x = pos.x / GAMEMANAGERS_TileSize;
		_tile.y = pos.z / GAMEMANAGERS_TileSize;
		if type == Circle_Player_Entity:
			_tile.shape = "c";
		if type == Square_Player_Entity:
			_tile.shape = "s";
		if type == Triangle_Player_Entity:
			_tile.shape = "t";
	
	add_child(_tile);
	
	if type == Circle_Player_Entity || type == Square_Player_Entity || type == Triangle_Player_Entity:
		Players.append(_tile);
	

# Iterate all Players can check if they are all Winning
func check_win() -> void:
	var all_on_goal : bool = true;
	for Player in Players:
		if !Player.onGoalTile:
			all_on_goal = false;
	
	if all_on_goal:
		_win();
	

# Update WinScreen's Moves Taken counter and show it
func _win() -> void:
	GameManager.level_complete = true;
	$WinScreen/PanelContainer/VBoxContainer/MarginContainer3/VBoxContainer/MovesTaken.text = "Moves Taken: " + str(GameManager.player_moves);
	$WinScreen.show();

# Dramatic pause so the player can see the level get built, might be annoying for bigger levels
func _wait(duration : float) -> void:
	if (GameManager.level_waiting):
		await get_tree().create_timer(duration).timeout;
	
