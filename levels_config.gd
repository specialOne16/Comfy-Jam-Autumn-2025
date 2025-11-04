const BASE_TILE_SIZE = Vector2(72, 72)
const MAP_SIZE = 10
const MAP_OFFSET = Vector2(
	(1920 - BASE_TILE_SIZE.x * MAP_SIZE) / 2,
	(1080 - BASE_TILE_SIZE.y * MAP_SIZE) / 2,
)

const BASE_LEVEL = {
	"player": Vector2i(3, 9),
	"pumkin": [
		Vector2i(1, 1),
		Vector2i(1, 5),
		Vector2i(1, 7),
		Vector2i(2, 2),
		Vector2i(2, 5),
		Vector2i(2, 8),
		Vector2i(3, 1),
		Vector2i(3, 4),
		Vector2i(4, 3),
		Vector2i(4, 5),
		Vector2i(4, 8),
		Vector2i(5, 3),
		Vector2i(5, 7),
		Vector2i(6, 2),
		Vector2i(6, 5),
		Vector2i(7, 7),
		Vector2i(8, 1),
		Vector2i(8, 7),
		
		Vector2i(0, 9),
		Vector2i(4, 9),
		Vector2i(9, 9),
		Vector2i(9, 3),
	],
	"h_haybale": [
		Vector2i(4, 2),
		Vector2i(5, 4),
		Vector2i(7, 5),
		Vector2i(3, 7),
		
		Vector2i(1, 0),
		Vector2i(3, 0),
		Vector2i(5, 0),
		Vector2i(7, 0),
		Vector2i(1, 9),
		Vector2i(5, 9),
		Vector2i(7, 9),
	],
	"v_haybale": [
		Vector2i(8, 3),
		Vector2i(1, 4),
		Vector2i(3, 6),
		Vector2i(6, 7),
		
		Vector2i(0, 2),
		Vector2i(0, 4),
		Vector2i(0, 6),
		Vector2i(0, 8),
		Vector2i(9, 2),
		Vector2i(9, 6),
		Vector2i(9, 8),
	]
}
