extends StaticBody2D
class_name Haybale

var map_position = Vector2i.ZERO

func place():
	position = Vector2(
		map_position.x * LevelsConfig.BASE_TILE_SIZE.x, 
		map_position.y * LevelsConfig.BASE_TILE_SIZE.y
	)
