extends Area3D

@export var speed = 2

func _ready():
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	position += Vector3(0, 0, 1) * delta * speed

func _on_body_entered (body: Node3D):
	if body.is_in_group("Character"): 
		print("Character entered gate")	
