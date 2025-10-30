extends Node2D
class_name Map

const HAYBALE = preload("res://haybale/haybale.tscn")

var grid: Array[Array]

func _init() -> void:
	grid.resize(5)
	for row in grid:
		row.resize(5)

func _ready() -> void:
	var position = Vector2i(randi_range(0, 4), randi_range(0, 4))
	var haybale = HAYBALE.instantiate()
	haybale.position = position * 64.0
	grid[position.x][position.y] = haybale
	add_child(haybale)
