extends Node2D
class_name Map

const PUMKIN = preload("res://pumkin/pumkin.tscn")
const H_HAYBALE = preload("res://haybale/h_haybale.tscn")
const V_HAYBALE = preload("res://haybale/v_haybale.tscn")
const START_AREA = preload("uid://bwp1851e60qyy")
const WIN_AREA = preload("uid://brokmxqw14236")

@onready var player: Player = $Player
@onready var player_camera: Camera2D = $PlayerCamera
@onready var pause_camera: Camera2D = $PauseCamera

var grid: Array[Array]
var player_camera_limit = Rect2(Vector2(600, 300), Vector2.ZERO)

func _ready() -> void:
	var level_map = LevelsConfig.load_level(LevelsConfig.current_level + 1)
	
	if not level_map.has("map_size"):
		get_tree().change_scene_to_file("res://cutscene/cutscene.tscn")
		return
	
	grid.resize(LevelsConfig.map_size.x)
	for row in grid:
		row.resize(LevelsConfig.map_size.y)
	
	player_camera_limit.end = Vector2(LevelsConfig.map_size - Vector2i(10, 8)) * LevelsConfig.BASE_TILE_SIZE
	if player_camera_limit.size.x < 0:
		player_camera_limit.size.x = 0
	
	for pumpkin_position in level_map.pumkin:
		_make_pumkin(pumpkin_position)
	
	for haybale_position in level_map.h_haybale:
		_make_h_haybale(haybale_position)
	
	for haybale_position in level_map.v_haybale:
		_make_v_haybale(haybale_position)
	
	_make_start_area(level_map.start, level_map.start_barrier)
	_make_win_area(level_map.win, level_map.win_barrier)
	
	EventManager.push_pumkin.connect(
		func(pumkin: Pumkin, direction: Vector2i):
			var target_position = pumkin.map_position + direction
			if target_position.x in range(LevelsConfig.map_size.x) and target_position.y in range(LevelsConfig.map_size.y):
				if grid[target_position.x][target_position.y] == null:
					grid[pumkin.map_position.x][pumkin.map_position.y] = null
					EventManager.pushing_pumkin.emit(true)
					await pumkin.move(direction)
					EventManager.pushing_pumkin.emit(false)
					grid[pumkin.map_position.x][pumkin.map_position.y] = pumkin
	)
	
	player_camera.make_current()

func _process(_delta: float) -> void:
	var temp = player.position
	player_camera.position = temp.clamp(player_camera_limit.position, player_camera_limit.end)
	
	if Input.is_action_just_pressed("ui_accept"):
		print(player.position, player_camera.position)

func _make_pumkin(pumkin_position: Vector2i):
	var pumkin = PUMKIN.instantiate()
	grid[pumkin_position.x][pumkin_position.y] = pumkin
	
	pumkin.map_position = pumkin_position
	pumkin.place()
	
	add_child(pumkin)

func _make_h_haybale(haybale_position: Vector2i):
	var haybale = H_HAYBALE.instantiate()
	grid[haybale_position.x][haybale_position.y] = haybale
	grid[haybale_position.x + 1][haybale_position.y] = haybale
	
	haybale.map_position = haybale_position
	haybale.place()
	
	add_child(haybale)

func _make_v_haybale(haybale_position: Vector2i):
	var haybale = V_HAYBALE.instantiate()
	grid[haybale_position.x][haybale_position.y] = haybale
	grid[haybale_position.x][haybale_position.y - 1] = haybale
	
	haybale.map_position = haybale_position
	haybale.place()
	
	add_child(haybale)

func _make_start_area(start_position: Vector2i, collision_direction: Vector2i):
	var start_area = START_AREA.instantiate()
	start_area.barrier_direction = collision_direction
	start_area.position = Vector2(
		start_position.x * LevelsConfig.BASE_TILE_SIZE.x, 
		start_position.y * LevelsConfig.BASE_TILE_SIZE.y
	)
	player.place(start_position)
	add_child(start_area)
	
func _make_win_area(win_position: Vector2i, collision_direction: Vector2i):
	var win_area = WIN_AREA.instantiate()
	win_area.barrier_direction = collision_direction
	win_area.position = Vector2(
		win_position.x * LevelsConfig.BASE_TILE_SIZE.x, 
		win_position.y * LevelsConfig.BASE_TILE_SIZE.y
	)
	add_child(win_area)


func _on_in_game_layer_restart() -> void:
	LevelsConfig.current_level -= 1
	get_tree().reload_current_scene()


func _on_in_game_layer_pause(is_paused: bool) -> void:
	player.pause_game = is_paused
	if is_paused:
		pause_camera.make_current()
	else:
		player_camera.make_current()
