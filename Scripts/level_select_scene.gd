extends Control

@export var level_id : String = "Level 00";
@export var level_name : String = "Name";
@export var level_difficulty : String = "⭐⭐⭐⭐⭐⭐⭐";
@export var level_target : int = 0; # Amount of moves to complete the level under
@export var level_pb : int = -1;
@export var level_txt_file : String = "res://Scenes/Levels/LevelData/Level-00_Testing.txt";

# Called when the node enters the scene tree for the first time.
func _ready():
	$"MarginContainer/PanelContainer/MarginContainer/Attributes/Level Select Title".text = " " + level_id + " - " + level_name;
	$"MarginContainer/PanelContainer/MarginContainer/Attributes/Difficulty Title".text = " Difficulty:" + level_difficulty;
	$"MarginContainer/PanelContainer/MarginContainer/Attributes/Target Moves Title".text = " Challenge: Under " + str(level_target) + " moves";
	if (level_pb != -1):
		$"MarginContainer/PanelContainer/MarginContainer/Attributes/PB Moves Title".text = " Personal Best: " + str(level_pb);
	else:
		$"MarginContainer/PanelContainer/MarginContainer/Attributes/PB Moves Title".text = " Personal Best: - ";
	
	$MarginContainer/PanelContainer/MarginContainer/Attributes/PlayButton.connect("pressed", load_level);

func load_level():
	GameManager.level_to_load = level_txt_file;
	GameManager.go_to_level();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
