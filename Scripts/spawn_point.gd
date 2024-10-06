extends Node3D

var spawning = false
@onready var basewaittime : float = $spawnInterval.wait_time 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawn_interval_timeout() -> void:
	if spawning:
		#$spawnInterval.wait_time=basewaittime
		#print("b",basewaittime-get_parent_node_3d().wave_number/10)
		print("bb",basewaittime-get_parent_node_3d().wave_number*0.1)
		$spawnInterval.wait_time=basewaittime-get_parent_node_3d().wave_number*0.1
		var base_scale = $Sprite3D.scale
		print("wait_time ", $spawnInterval.wait_time)
		$Sprite3D.scale*=1.2
		var creature_scene = preload("res://Scenes/creature.tscn")
		var creature_instance = creature_scene.instantiate()
		creature_instance.position = get_global_position()
		$"../NavigationRegion3D".add_child(creature_instance)
		$"../NavigationRegion3D".bake_navigation_mesh()
		await get_tree().create_timer(0.2).timeout
		$Sprite3D.scale=base_scale
