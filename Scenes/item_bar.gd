extends HBoxContainer

@export var test_tower : PackedScene
@export var fist : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_test_tower_pressed() -> void:
	$"../../../..".selected_tower=test_tower

func _on_fist_pressed() -> void:
	$"../../../..".selected_tower=fist
