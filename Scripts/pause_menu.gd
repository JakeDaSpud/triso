extends Control

func resume():
	self.hide();
	get_tree().paused = false;

func pause():
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
