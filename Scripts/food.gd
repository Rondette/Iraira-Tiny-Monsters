extends StaticBody3D
@onready var health : int = max_health
@export var max_health : int = 100
@export var foods : Array[Texture]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite3D2.texture=foods.pick_random()
	$SubViewport/CanvasLayer/MarginContainer/health.max_value=max_health
	$SubViewport/CanvasLayer/MarginContainer/health.value=health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func eat(strength : int):
	$SubViewport/CanvasLayer/MarginContainer/health.value=health
	health-=strength
	if health<=0:
		self.queue_free()
