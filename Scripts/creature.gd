extends CharacterBody3D

@export var speed = 5.0
var food_tag = "food"
@export var strength : int = 10
@export var eating_distance : float = 3.0
@onready var health : int = max_health
@export var max_health : int = 20
var nearest_food
var nearest_tower
var navigation_agent: NavigationAgent3D
var full = false
func _ready() -> void:
	$SubViewport/CanvasLayer/MarginContainer/health.max_value=max_health
	$SubViewport/CanvasLayer/MarginContainer/health.value=health
	navigation_agent = NavigationAgent3D.new()
	add_child(navigation_agent)
	move_to_nearest_food()

func move_to_nearest_food() -> void:
	nearest_food = find_nearest_food()
	nearest_tower = find_nearest_tower()
	if nearest_food && !full:
		navigation_agent.target_position = nearest_food.global_transform.origin
	elif full && nearest_tower:
		navigation_agent.target_position = nearest_tower.global_transform.origin

func find_nearest_food() -> Node3D:
	var shortest_distance = INF
	var nearest_food: Node3D = null
	for child in get_tree().get_nodes_in_group(food_tag):
		var distance = global_transform.origin.distance_to(child.global_transform.origin)
		if distance < shortest_distance:
			shortest_distance = distance
			nearest_food = child
	return nearest_food
func find_nearest_tower() -> Node3D:
	var shortest_distance = INF
	var nearest_tower: Node3D = null
	for child in get_tree().get_nodes_in_group("tower"):
		var distance = global_transform.origin.distance_to(child.global_transform.origin)
		if distance < shortest_distance:
			shortest_distance = distance
			nearest_tower = child
	if nearest_tower:
		return nearest_tower
	else:
		return find_nearest_food()

func _physics_process(delta: float) -> void:
	if nearest_food or nearest_tower and global_transform.origin.distance_to(nearest_food.global_transform.origin) > eating_distance:
		var direction = (navigation_agent.get_next_path_position() - global_transform.origin).normalized()
		velocity = direction * speed
		if scale.x>1.5:
			move_to_nearest_food()
			full=true
	else:
		velocity = Vector3.ZERO
	move_and_slide()


func _on_timer_timeout() -> void:
	if nearest_food != null and global_transform.origin.distance_to(nearest_food.global_transform.origin) <= eating_distance:
		nearest_food.eat(strength)
		velocity = Vector3.ZERO
		self.scale*=1.1
		self.eating_distance*=1.1
	elif nearest_food == null:
		move_to_nearest_food()
	elif nearest_tower !=null and global_transform.origin.distance_to(nearest_tower.global_transform.origin) <= eating_distance:
		nearest_tower.hurt(strength)
func hurt(damage):
	health-=damage
	$SubViewport/CanvasLayer/MarginContainer/health.value=health
	if health<=0:
		self.queue_free()
