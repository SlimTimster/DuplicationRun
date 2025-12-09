# Gate class. Has speed, math operation, number and more
class_name Gate extends Area3D

# All possible math operations
const OPERATIONS = {
	"ADD": "+",
	"SUBTRACT": "-",
	"MULTIPLY": "*",
	"DIVIDE": ":"
}

@onready var text : Label3D = $Label3D
@export var speed : int = 20
var operation : String = OPERATIONS.ADD
var operand : int = 10

func _ready():
	var rng : RandomNumberGenerator = RandomNumberGenerator.new()
	body_entered.connect(_on_body_entered)
	
	operand = rng.randi_range(0, 10) * 10 #Random int from 0 to 100 in steps of 10
	operation = OPERATIONS.values()[rng.randi_range(0, OPERATIONS.size() - 1)]
	
	text.text = operation + str(operand)

func _physics_process(delta: float) -> void:
	position += Vector3(0, 0, 1) * delta * speed

func _on_body_entered (body: Node3D):
	if body.is_in_group("Character"): 
		print("Character entered gate: " + operation + str(operand))
		var character_manager = get_node("/root/Main/CharacterManager")
		character_manager.spawn_characters(operation, operand)
