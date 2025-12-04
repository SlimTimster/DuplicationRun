extends CharacterBody3D

@export_range(1, 10, 1)
var speed = 5

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	pass

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = Vector3(input_direction.x, 0, input_direction.y) * speed
	
