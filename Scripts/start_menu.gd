extends Control

# Initialise all Menus
var main : Control;
var settings : Control;
var level_select : Control;
var credits : Control;

var settings_master_slider : Control;
var settings_music_slider : Control;
var settings_sfx_slider : Control;

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Grab all Menus
	main = $Main;
	settings = $Settings;
	level_select = $LevelSelect;
	credits = $Credits;
	
	# Grab all Audio Sliders
	settings_master_slider = $Settings/HBoxContainer/VBoxContainer/Master/Master_Slider;
	settings_music_slider = $Settings/HBoxContainer/VBoxContainer/Music/Music_Slider;
	settings_sfx_slider = $Settings/HBoxContainer/VBoxContainer/SFX/SFX_Slider;
	
	# Set Audio Defaults, grabbing by AudioServer index
	settings_master_slider.value = db_to_linear(AudioServer.get_bus_volume_db(0));
	settings_sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(1));
	settings_music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(2));
	

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

func settings_set_level_colour(level_color_index : int) -> void:
	GameManager.level_color = $Settings/HBoxContainer/VBoxContainer/Level_Colour/Level_Colour_Dropdown.get_item_text(level_color_index);

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

func setting_set_master_volume() -> void:
	release_focus();
	AudioServer.set_bus_volume_db(0, linear_to_db(settings_master_slider.value));

func setting_set_sfx_volume() -> void:
	release_focus();
	AudioServer.set_bus_volume_db(1, linear_to_db(settings_sfx_slider.value));

func setting_set_music_volume() -> void:
	release_focus();
	AudioServer.set_bus_volume_db(2, linear_to_db(settings_music_slider.value));

# Close game window
func quit() -> void:
	get_tree().quit();
