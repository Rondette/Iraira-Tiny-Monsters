extends Control

var lerpPause = false
var next = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		var paused = get_tree().paused as bool
		get_tree().paused = !paused
		if paused:
			next=!next
			lerpPause = false
		else:
			lerpPause = true
	if lerpPause:
		position.x = lerp(position.x, 0.0, 11.0*delta)
	else:
		if next==true:
			position.x = lerp(position.x, -2000.0, 11.0*delta)
		else:
			position.x = lerp(position.x, 2000.0, 11.0*delta)
func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	Globals.loadScene("res://Scenes/main_menu.tscn")
func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_resume_pressed() -> void:
	var paused = get_tree().paused as bool
	get_tree().paused = !paused
	if paused:
		next=!next
		lerpPause = false
	else:
		lerpPause = true
