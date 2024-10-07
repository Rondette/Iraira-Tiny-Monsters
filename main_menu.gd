extends Control

var lerpStartTxt = false
var lerpSelectTxt = false
var lerpQuitTxt = false
var lerpCreditsTxt = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if lerpStartTxt:
		$StartText.position.x=lerp($StartText.position.x,0.0,10*delta)
	else:
		$StartText.position.x=lerp($StartText.position.x,-4000.0,10*delta)
		
	if lerpSelectTxt:
		$LevelSelectText.position.y=lerp($LevelSelectText.position.y,0.0,10*delta)
	else:
		$LevelSelectText.position.y=lerp($LevelSelectText.position.y,-4000.0,10*delta)

	if lerpQuitTxt:
		$QuitText.position.x=lerp($QuitText.position.x,0.0,10*delta)
	else:
		$QuitText.position.x=lerp($QuitText.position.x,4000.0,10*delta)

	if lerpCreditsTxt:
		$Credits_Text.position.y=lerp($Credits_Text.position.y,0.0,10*delta)
	else:
		$Credits_Text.position.y=lerp($Credits_Text.position.y,4000.0,10*delta)

func _on_start_mouse_entered() -> void:
	lerpStartTxt=true
	$MM_Buttons/HBoxContainer/TextureRect.visible=true
func _on_start_mouse_exited() -> void:
	lerpStartTxt=false
	$MM_Buttons/HBoxContainer/TextureRect.visible=false

func _on_level_select_mouse_entered() -> void:
	lerpSelectTxt = true
	$MM_Buttons/HBoxContainer5/TextureRect.visible=true
func _on_level_select_mouse_exited() -> void:
	lerpSelectTxt = false
	$MM_Buttons/HBoxContainer5/TextureRect.visible=false

func _on_credits_mouse_entered() -> void:
	lerpCreditsTxt=true
	$MM_Buttons/HBoxContainer3/TextureRect.visible=true
func _on_credits_mouse_exited() -> void:
	lerpCreditsTxt=false
	$MM_Buttons/HBoxContainer3/TextureRect.visible=false

func _on_exit_mouse_entered() -> void:
	lerpQuitTxt=true
	$MM_Buttons/HBoxContainer4/TextureRect.visible=true
func _on_exit_mouse_exited() -> void:
	lerpQuitTxt=false
	$MM_Buttons/HBoxContainer4/TextureRect.visible=false


func _on_start_pressed() -> void:
	Globals.loadScene("res://Scenes/test.tscn")
func _on_exit_pressed() -> void:
	get_tree().quit()
func _on_level_select_pressed() -> void:
	Globals.loadScene("res://Scenes/LevelSelect.tscn")


func _on_credits_pressed() -> void:
	Globals.loadScene("res://Scenes/Credits.tscn")
