extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_main_menu_pressed() -> void:
	Globals.loadScene("res://Scenes/main_menu.tscn")


func _on_next_level_pressed() -> void:
	if Globals.currentLevel==1:
		Globals.loadScene("res://Scenes/level2.tscn")
	elif Globals.currentLevel==2:
		Globals.loadScene("res://Scenes/level3.tscn")
	elif Globals.currentLevel==3:
		Globals.loadScene("res://Scenes/level4.tscn")
	elif Globals.currentLevel==4:
		Globals.loadScene("res://Scenes/level5.tscn")
	elif Globals.currentLevel==5:
		Globals.loadScene("res://Scenes/level6.tscn")
	elif Globals.currentLevel==6:
		Globals.loadScene("res://Scenes/main_menu.tscn")
