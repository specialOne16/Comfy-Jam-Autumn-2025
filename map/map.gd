extends Node2D
class_name Map

const PUMKIN = preload("res://pumkin/pumkin.tscn")
const H_HAYBALE = preload("res://haybale/h_haybale.tscn")
const V_HAYBALE = preload("res://haybale/v_haybale.tscn")

@onready var player: Player = $Player

var grid: Array[Array]


func _init() -> void:
	grid.resize(LevelsConfig.MAP_SIZE)
	for row in grid:
		row.resize(LevelsConfig.MAP_SIZE)

func _ready() -> void:
	#for x in LevelsConfig.MAP_SIZE:
		#for y in LevelsConfig.MAP_SIZE:
			#_make_pumkin(Vector2i(x, y))
	
	for pumpkin_position in LevelsConfig.BASE_LEVEL.pumkin:
		_make_pumkin(pumpkin_position)
	
	for haybale_position in LevelsConfig.BASE_LEVEL.h_haybale:
		_make_h_haybale(haybale_position)
	
	for haybale_position in LevelsConfig.BASE_LEVEL.v_haybale:
		_make_v_haybale(haybale_position)
	
	player.place(LevelsConfig.BASE_LEVEL.player)
	
	EventManager.push_pumkin.connect(
		func(pumkin: Pumkin, direction: Vector2i):
			var target_position = pumkin.map_position + direction
			if target_position.x in range(LevelsConfig.MAP_SIZE) and target_position.y in range(LevelsConfig.MAP_SIZE):
				if grid[target_position.x][target_position.y] == null:
					grid[pumkin.map_position.x][pumkin.map_position.y] = null
					EventManager.pushing_pumkin.emit(true)
					await pumkin.move(direction)
					EventManager.pushing_pumkin.emit(false)
					grid[pumkin.map_position.x][pumkin.map_position.y] = pumkin
	)

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
