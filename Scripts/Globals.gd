extends Node
var sceneToLoad
var loadingScreen = preload("res://Scenes/loading_screen.tscn")
var currentLevel : int
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func loadScene(scene):
	sceneToLoad=scene
	get_tree().change_scene_to_packed(loadingScreen)
