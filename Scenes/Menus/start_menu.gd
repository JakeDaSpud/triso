extends Control

# Initialise all Menus
var main : Control;
var settings : Control;
var level_select : Control;
var credits : Control;

# Called when the node enters the scene tree for the first time.
func _ready():
	# Grab all Menus
	main = $Main;
	settings = $Settings;
	level_select = $LevelSelect;
	credits = $Credits;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func open_main_menu() -> void:
	settings.hide();
	level_select.hide();
	credits.hide();
	
	main.show();;

func open_settings_menu() -> void:
	main.hide();
	level_select.hide();
	credits.hide();
	
	settings.show();

func open_level_select_menu() -> void:
	main.hide();
	settings.hide();
	credits.hide();
	
	level_select.show();

func open_credits_menu() -> void:
	main.hide();
	settings.hide();
	level_select.hide();
	
	credits.show();

func settings_toggle_fullscreen(toggled_on : bool) -> void:
	
	if (toggled_on):
		get_window().mode = Window.Mode.MODE_EXCLUSIVE_FULLSCREEN;
	
	elif (!toggled_on):
		get_window().mode = Window.Mode.MODE_WINDOWED;

func settings_set_resolution_and_window_size(index : int) -> void:
	
	$Settings/HBoxContainer/VBoxContainer/Fullscreen/Fullscreen_Check.set_pressed(false);
	
	# 16:9 Resolutions
	if (index == 1):
		DisplayServer.window_set_size(Vector2i(1920, 1080));
	elif (index == 2):
		DisplayServer.window_set_size(Vector2i(1600, 900));
	elif (index == 3):
		DisplayServer.window_set_size(Vector2i(1280, 720));
	elif (index == 4):
		DisplayServer.window_set_size(Vector2i(1024, 576));
	
	# 4:3 Resolutions
	elif (index == 6):
		DisplayServer.window_set_size(Vector2i(1920, 1440));
	elif (index == 7):
		DisplayServer.window_set_size(Vector2i(1280, 960));
	elif (index == 8):
		DisplayServer.window_set_size(Vector2i(1024, 768));
	elif (index == 9):
		DisplayServer.window_set_size(Vector2i(800, 600));
	elif (index == 10):
		DisplayServer.window_set_size(Vector2i(640, 480));

# Close game window
func quit() -> void:
	get_tree().quit();
