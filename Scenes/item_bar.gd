extends HBoxContainer

@export var test_tower : PackedScene
@export var test_tower_quantity : int = 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$test_tower/amount.text=str(test_tower_quantity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$test_tower/amount.text=str(test_tower_quantity)


func _on_test_tower_pressed() -> void:
	$"../../../..".selected_tower=test_tower
	$"../../../..".tower_name="test"
