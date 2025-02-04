extends Node

var level_to_load : String = "";
var level_complete : bool = false;
var player_moves : int = 0;

# Level Settings
var level_color : String = "Random";
var level_waiting : bool = true;
var colors : Dictionary = {
	"Red" : "#f05e54",
	"Orange" : "#f09054",
	"Yellow" : "#f2e638",
	"Green" : "#32dc32",
	"Seafoam" : "#39e9be",
	"Blue" : "#3f88e8",
	"Pastel Blue" : "#72eaf7",
	"Purple" : "#9d54f0",
	"Pink" : "#ffbdff",
	"Brown" : "#ab7543",
	"Grey" : "#696664",
	"White" : "#ebebeb"
}

# Audio Settings
var master_volume : int = 100;
var music_volume : int = 100;
var sfx_volume : int = 100;

# Control Settings
var camera_sensitivity : float = 0.3;
var inverted_camera : bool = false;

func check_win() -> void:
	print_debug("current scene name: " + get_tree().current_scene.name);
	if get_tree().current_scene.name == "Dynamic_Level":
		$"/root/Dynamic_Level".check_win();

func increment_player_move() -> void:
	player_moves = player_moves + 1;

func go_to_level() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/Dynamic_Level.tscn");

func go_to_menu() -> void:
	level_to_load = "";
	level_complete = false;
	player_moves = 0;
	get_tree().change_scene_to_file("res://Scenes/Menus/Start_Menu.tscn");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	pass
