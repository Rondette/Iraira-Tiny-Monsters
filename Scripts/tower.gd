extends StaticBody3D

@export var damage : int = 1
@onready var health : int = max_health
@export var max_health : int = 20
@export var cost : int = 5
@export var towerName : String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SubViewport/CanvasLayer/MarginContainer/health.max_value=max_health
	$SubViewport/CanvasLayer/MarginContainer/health.value=health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var nearest_creature = find_nearest_creature()
	if nearest_creature!= null:
		look_at(nearest_creature.get_global_position())
func find_nearest_creature() -> Node3D:
	var shortest_distance = INF
	var nearest_creature: Node3D = null
	for child in get_tree().get_nodes_in_group("creature"):
		var distance = child.global_transform.origin.distance_to(child.global_transform.origin)
		if distance < shortest_distance:
			shortest_distance = distance
			nearest_creature = child
	return nearest_creature

func _on_timer_timeout() -> void:
	var nearest_creature = find_nearest_creature()
	if nearest_creature:
		$RayCast3D.look_at(nearest_creature.get_global_position())
		$RayCast3D.force_raycast_update()
		if $RayCast3D.is_colliding():
			var standard_pos = $Sprite3D2.position
			var collider = $RayCast3D.get_collider()
			if collider and collider.is_in_group("creature"):
				if towerName=="fingergun":
					$Sprite3D2.rotation.z=-19.0
				elif towerName =="fist":
					$Sprite3D2.position.y=1.3
				collider.hurt(damage)
			await get_tree().create_timer(0.1).timeout
			$Sprite3D2.rotation.z=0.0
			$Sprite3D2.position=standard_pos
func hurt(damage):
	$SubViewport/CanvasLayer/MarginContainer/health.value=health
	health-=damage
	if health<=0:
		self.queue_free()
