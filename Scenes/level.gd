extends Node3D
@export var spawnNode : Node3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawn_clock_timeout() -> void:
		var creature_scene = preload("res://Scenes/creature.tscn")
		var creature_instance = creature_scene.instantiate()
		creature_instance.position = spawnNode.get_global_position()
		add_child(creature_instance)
