extends Node

@export var character : PackedScene
@export var gate : PackedScene
@onready var gate_spawn_right : Vector3 = $"../GateSpawnPosRight".position
@onready var gate_spawn_left : Vector3 = $"../GateSpawnPosLeft".position
@onready var char_spawn_pos : Vector3 = $"../MovementSphere".position - Vector3(0,0.6,0)

var characters : Array[Node] = []
var num_characters : int = 1

func _ready() -> void:
	spawn_characters("+", 1)

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("ui_accept")):
		spawn_gates()

# Spawns 2 gates, one on the left, one on the right
func spawn_gates():
	print("Spawning 2 Gates")
	var gate_left : Node = gate.instantiate()
	gate_left.position = gate_spawn_left
	add_child(gate_left)
	
	var gate_right : Node = gate.instantiate()
	gate_right.position = gate_spawn_right
	add_child(gate_right)

# Spawns or Removes characters until actual number matches the new number
func spawn_characters(operation : String, operand : int = 1):
	print("Spawning characters for operation: " + operation + " with operand: " + str(operand))
	
	# Determine how many to spawn based on operation
	match operation:
		"+":
			for i in range(operand):
				var new_character = character.instantiate()
				new_character.position = char_spawn_pos + Vector3(i, 0, i)
				add_child(new_character)
				characters.append(new_character)
		"-":
			for i in range(1, operand):
				characters[i].queue_free()
				characters.remove_at(i)			
	
	print("Total characters now: " + str(characters.size()))
