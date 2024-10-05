extends Camera3D

@export var selected_tower : PackedScene
var tower_name : String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# node.position = get_global_mouse_position() - camera.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("place"):
		if selected_tower !=null:
			if tower_name=="test" && $CanvasLayer/Control/MarginContainer2/ItemBar.test_tower_quantity>0:
				$CanvasLayer/Control/MarginContainer2/ItemBar.test_tower_quantity-=1
				spawnTower()
func ScreenPointToRay() -> Vector3:
	var spaceState = get_world_3d().direct_space_state
	var mousePos = get_viewport().get_mouse_position()
	var rayOrigin = project_ray_origin(mousePos)
	var rayEnd = rayOrigin + project_ray_normal(mousePos) * 2000
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = rayOrigin
	ray_query.to = rayEnd
	ray_query.collide_with_areas = true  # Adjust as necessary
	var ray_result = spaceState.intersect_ray(ray_query)
	if ray_result.has("position"):
		var collider = ray_result["collider"]
		 
		if collider.is_in_group("floor"):
			print("Hit floor at position: ", ray_result["position"])
			return ray_result["position"]
		else:
			print("Hit something, but not the floor.")
			return Vector3(0,-900,0)
	else:
		return Vector3(0,-900,0)
func spawnTower():
	var tower_instance = selected_tower.instantiate()
	tower_instance.position = ScreenPointToRay()
	$"../NavigationRegion3D".add_child(tower_instance)
	$"../NavigationRegion3D".bake_navigation_mesh()
