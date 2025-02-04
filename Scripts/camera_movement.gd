extends Node3D

var camera_anglev : int = 0;

func _input(event) -> void:
	if event is InputEventMouseMotion:
		self.rotate_y(deg_to_rad(-event.relative.x * GameManager.camera_sensitivity));
		
		var changev = -event.relative.y * GameManager.camera_sensitivity;
		
		if camera_anglev + changev > -50 and camera_anglev + changev < 50:
			camera_anglev += changev;
			#self.rotate_x(deg_to_rad(changev))
	

func _process(delta):
	if Input.is_action_pressed("Rotate Right"):
		self.rotate_y(deg_to_rad(10 * GameManager.camera_sensitivity));
	
	if Input.is_action_pressed("Rotate Left"):
		self.rotate_y(deg_to_rad(-10 * GameManager.camera_sensitivity));
	
