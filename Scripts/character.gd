extends CharacterBody3D

@export var move_speed = 6
@export var move_min_dist = 2

@export var rotation_speed = 6
@export var rotation_min_dist = 2

@onready var movementSphere = $"../../MovementSphere"

func _physics_process(delta: float) -> void:
	# Rotate character to look at sphere
	var target_position = movementSphere.position
	var direction = Vector3(target_position.x, position.y, target_position.z) - position	
	if direction.length() > rotation_min_dist:
		var target_transform = transform.looking_at(position + direction, Vector3(0, 1, 0), true)
		transform.basis = transform.basis.slerp(target_transform.basis, rotation_speed * delta)

	# Move character towards teh sphere if distance great enough
	var dist_to_sphere : float = (movementSphere.position - position).length()
	if(dist_to_sphere >= move_min_dist):
		move_and_collide(transform.basis.z * move_speed * delta)
		if $AnimationPlayer.current_animation != "Walk_Formal":
			$AnimationPlayer.play("Walk_Formal", 0.2)
	else:
		if $AnimationPlayer.current_animation != "Idle":
			$AnimationPlayer.play("Idle", 0.2)
