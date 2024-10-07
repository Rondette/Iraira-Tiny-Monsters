extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level_1_pressed() -> void:
	Globals.loadScene("res://Scenes/test.tscn")


func _on_level_2_pressed() -> void:
	Globals.loadScene("res://Scenes/level2.tscn")


func _on_back_pressed() -> void:
	Globals.loadScene("res://Scenes/main_menu.tscn")


func _on_level_3_pressed() -> void:
	Globals.loadScene("res://Scenes/level3.tscn")


func _on_level_4_pressed() -> void:
	Globals.loadScene("res://Scenes/level4.tscn")


func _on_level_5_pressed() -> void:
	Globals.loadScene("res://Scenes/level5.tscn")


func _on_level_6_pressed() -> void:
	Globals.loadScene("res://Scenes/level6.tscn")
