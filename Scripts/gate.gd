# Gate class. Has speed, math operation, number and more
class_name Gate extends Area3D

# All possible math operations
const OPERATIONS = {
	"ADD": "+",
	"SUBTRACT": "-",
	"MULTIPLY": "*",
	"DIVIDE": "/"
}

@onready var text : Label3D = $Label3D
@export var speed : int = 20
var operation : String = OPERATIONS.ADD
var operand : int = 10

func _ready():
	var rng : RandomNumberGenerator = RandomNumberGenerator.new()
	body_entered.connect(_on_body_entered)
	
	operation = OPERATIONS.values()[rng.randi_range(0, OPERATIONS.size() - 1)]
	operand = rng.randi_range(1, 10) * 10 #Random int from 0 to 100 in steps of 10
	
	if operation == OPERATIONS.MULTIPLY || operation == OPERATIONS.DIVIDE:
		operand /= 10
		
	text.text = operation + str(operand)

func _physics_process(delta: float) -> void:
	position += Vector3(0, 0, 1) * delta * speed

func _on_body_entered (body: Node3D):
	if body.is_in_group("Character"): 
		body_entered.disconnect(_on_body_entered)
		print("Character entered gate: " + operation + str(operand))
		var character_manager = get_node("/root/Main/CharacterManager")
		character_manager.spawn_characters(operation, operand)
