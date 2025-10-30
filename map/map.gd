extends Node2D
class_name Map

const HAYBALE = preload("res://haybale/haybale.tscn")

var grid: Array[Array]

func _init() -> void:
	grid.resize(5)
	for row in grid:
		row.resize(5)

func _ready() -> void:
	for i in range(1):
		_make_haybale(Vector2i(i, 0))

func _make_haybale(position: Vector2i):
	var haybale = HAYBALE.instantiate()
	haybale.position = Vector2(position.x * 72, position.y * 24)
	grid[position.x][position.y] = haybale
	add_child(haybale)
