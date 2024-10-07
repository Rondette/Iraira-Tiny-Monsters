extends Node3D
@export var spawnNode : Node3D
@export var wave_vfx : PackedScene
var wave_number = 1
var next :bool
@export var time_between_waves : int = 3
@export var wave_time : int = 5
@export var max_waves : int = 10
@export var level_number : int
@export var boss_waves : Array[int]
@export var boss_sprites : Array[Texture]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.currentLevel=level_number
	var wave_vfx_spawn = wave_vfx.instantiate()
	for n in wave_vfx_spawn.get_children():
		if n.name=="SubViewport":
			for a in n.get_children():
				a.text=str("Game Begin!")
		if n.name=="CPUParticles2D":
			n.set_emitting(true)
		add_child(wave_vfx_spawn)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawn_clock_timeout() -> void:
	var wave_vfx_spawn = wave_vfx.instantiate()
	for child in get_tree().get_nodes_in_group("spawnPoint"):
		next = !child.spawning
		await get_tree().create_timer(0.75).timeout
		child.spawning=next
	for n in wave_vfx_spawn.get_children():
		if n.name=="SubViewport": 
			for a in n.get_children():
				if next==true:
					a.text=str("Wave ", wave_number)
					wave_number+=1
					$waveInterval.wait_time=time_between_waves
				else:
					a.text=str("Wave End")
					$waveInterval.wait_time=wave_time
					wave_time+=5
		if n.name=="CPUParticles2D":
			n.set_emitting(true)
	add_child(wave_vfx_spawn)
	if wave_number >max_waves:
		Globals.loadScene("res://Scenes/level_win_screen.tscn")
