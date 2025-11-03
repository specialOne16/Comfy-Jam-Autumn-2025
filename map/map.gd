extends Node2D
class_name Map

const PUMKIN = preload("res://pumkin/pumkin.tscn")
const MAP_SIZE = 8

var grid: Array[Array]

func _init() -> void:
	grid.resize(MAP_SIZE)
	for row in grid:
		row.resize(MAP_SIZE)

func _ready() -> void:
	for pumpkin_position in LevelsConfig.BASE_LEVEL.pumkin:
		_make_pumkin(pumpkin_position)
	
	EventManager.push_pumkin.connect(
		func(pumkin: Pumkin, direction: Vector2i):
			var target_position = pumkin.map_position + direction
			if target_position.x in range(MAP_SIZE) and target_position.y in range(MAP_SIZE):
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
