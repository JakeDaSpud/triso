extends Node

var level_to_load : String = "";

var level_color : String = "Random";
var level_waiting : bool = true;

var master_volume : int = 100;
var music_volume : int = 100;
var sfx_volume : int = 100;

func go_to_level():
	get_tree().change_scene_to_file("res://Scenes/Levels/Dynamic_Level.tscn");

func go_to_menu():
	get_tree().change_scene_to_file("res://Scenes/Menus/StartMenu.tscn");

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
