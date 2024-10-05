extends Node
# Called when the node enters the scene tree for the first time.
func _ready():
	ResourceLoader.load_threaded_request(Globals.sceneToLoad)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var progress = []
	ResourceLoader.load_threaded_get_status(Globals.sceneToLoad, progress)
	$MarginContainer/ProgressBar.value=progress[0]*100
	if progress[0] == 1:
		var packedScene = ResourceLoader.load_threaded_get(Globals.sceneToLoad)
		get_tree().change_scene_to_packed(packedScene)
