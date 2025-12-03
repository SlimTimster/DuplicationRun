extends CharacterBody3D

@export var speed = 5

@onready var movementSphere = $"../MovementSphere"

func _physics_process(delta: float) -> void:
	velocity = (movementSphere.position - position) * speed
	move_and_slide()
