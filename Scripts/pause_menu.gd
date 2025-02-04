extends Control

func resume():
	self.hide();
	get_tree().paused = false;

func pause():
	if (!GameManager.level_complete):
		get_tree().paused = true;
		self.show();

func main_menu():
	get_tree().paused = false;
	GameManager.go_to_menu();

func _input(InputEvent) -> void:
	if (Input.is_action_just_pressed("Pause")):
		if (self.visible):
			resume();
		else:
			pause();


func _on_level_select_pressed():
	pass # Replace with function body.
