extends Camera3D

@export var selected_tower : PackedScene
@export var money : int
var canPlace = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# node.position = get_global_mouse_position() - camera.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$CanvasLayer/Control/MarginContainer/FoodRemaining/Money.text=str("Money: $", money)
	if Input.is_action_just_pressed("place"):
		if selected_tower !=null:
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
			canPlace=true
			return ray_result["position"]
		else:
			canPlace=false
			print("Hit something, but not the floor.")
			return Vector3(0,-900,0)
	else:
		canPlace=false
		return Vector3(0,-900,0)
func spawnTower():
		var tower_instance = selected_tower.instantiate()
		tower_instance.position = ScreenPointToRay()
		if canPlace:
			if money >= tower_instance.cost:
				$"../NavigationRegion3D".add_child(tower_instance)
				money-=tower_instance.cost
			$"../NavigationRegion3D".bake_navigation_mesh()
