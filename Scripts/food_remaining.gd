extends VBoxContainer
var totalHealth : int
var currentHealth : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	totalHealth=0
	currentHealth=0
	for child in get_tree().get_nodes_in_group("food"):
		currentHealth += child.health
		totalHealth += child.max_health
	$FoodBar.value=currentHealth
	$FoodBar.max_value=totalHealth
	if currentHealth<=0:
		Globals.loadScene("res://Scenes/game_over.tscn")
