extends Node3D

var spawning = false
@onready var basewaittime : float = $spawnInterval.wait_time 
var bossWave = false
var bossSpawned = false
var base_scale
@export var enemy_health_mult : int = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	base_scale = $Sprite3D.scale


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawn_interval_timeout() -> void:
	if spawning:
		$Sprite3D.scale=base_scale
		#print("bb",basewaittime-get_parent_node_3d().wave_number*0.1)
		$spawnInterval.wait_time=basewaittime-get_parent_node_3d().wave_number*0.05
		if get_parent_node_3d().wave_number in get_parent_node_3d().boss_waves:
			bossWave=true
		else:
			bossWave=false
		#print("wait_time ", $spawnInterval.wait_time)
		var creature_scene = preload("res://Scenes/creature.tscn")
		var creature_instance = creature_scene.instantiate()
		creature_instance.position = get_global_position()
		if bossWave == false:
			creature_instance.max_health*=(1+get_parent_node_3d().wave_number*0.1)*enemy_health_mult
			print(creature_instance.max_health)
			bossSpawned = false
			$Sprite3D.scale*=1.2
			$"../NavigationRegion3D".add_child(creature_instance)
		elif bossSpawned == false:
			bossSpawned = true
			creature_instance.value = 50
			creature_instance.strength = 25
			creature_instance.max_health=100+get_parent_node_3d().wave_number*100
			$"../NavigationRegion3D".add_child(creature_instance)
			var tex = get_parent_node_3d().boss_sprites.pick_random()
			for n in creature_instance.get_children():
				if n.name=="Sprite3D2":
					print(n.name)
					n.texture=tex
			creature_instance.position.y+=0.5
			print("boss_sPANWED")
			$Sprite3D.scale*=1.5
		$"../NavigationRegion3D".bake_navigation_mesh()
		await get_tree().create_timer(0.2).timeout
		$Sprite3D.scale=base_scale
