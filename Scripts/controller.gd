extends CharacterBody3D

@export_range(1, 10, 1)
var speed = 5

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	pass

func get_input():
	var input_direction = Input.get_vector("ui_right", "ui_left", "ui_down", "ui_up")
	velocity = Vector3(input_direction[0], 0, 0) * speed
	
