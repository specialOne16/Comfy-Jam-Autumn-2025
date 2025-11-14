class_name LevelsConfig

const BASE_TILE_SIZE = Vector2(72, 72)
static var map_size: Vector2i
static var map_offset: Vector2
static var current_level: int = 0

static func load_level(number: int) -> Dictionary:
	current_level = number
	match number:
		1: 
			map_size = LEVEL_1.map_size
			map_offset = Vector2(
				(1920 - BASE_TILE_SIZE.x * map_size.x) / 2,
				(1080 - BASE_TILE_SIZE.y * map_size.y) / 2,
			)
			return LEVEL_1
		2: 
			map_size = LEVEL_2.map_size
			map_offset = Vector2(
				(1920 - BASE_TILE_SIZE.x * map_size.x) / 2,
				(1080 - BASE_TILE_SIZE.y * map_size.y) / 2,
			)
			return LEVEL_2
		3: 
			map_size = LEVEL_3.map_size
			map_offset = Vector2(
				(1920 - BASE_TILE_SIZE.x * map_size.x) / 2,
				(1080 - BASE_TILE_SIZE.y * map_size.y) / 2,
			)
			return LEVEL_3
		_: 
			map_size = Vector2i.ZERO
			map_offset = Vector2.ZERO
			return {}

const LEVEL_1 = {
	"map_size": Vector2i(10, 10),
	"start": Vector2i(3, 9),
	"start_barrier": Vector2i(0, 1),
	"win": Vector2i(9, 4),
	#"win": Vector2i(3, 8),
	"win_barrier": Vector2i(1, 0),
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

const LEVEL_2 = {
	"map_size": Vector2i(12, 12),
	"start": Vector2i(0, 6),
	"start_barrier": Vector2i(-1, 0),
	"win": Vector2i(8, 0),
	#"win": Vector2i(1, 6),
	"win_barrier": Vector2i(0, -1),
	"pumkin": [
		Vector2i(0, 5),
		Vector2i(0, 11),
		Vector2i(1, 1),
		Vector2i(1, 4),
		Vector2i(1, 9),
		Vector2i(1, 10),
		Vector2i(2, 3),
		Vector2i(2, 5),
		Vector2i(2, 8),
		Vector2i(3, 6),
		Vector2i(3, 10),
		Vector2i(4, 1),
		Vector2i(4, 4),
		Vector2i(4, 8),
		Vector2i(5, 3),
		Vector2i(5, 8),
		Vector2i(6, 1),
		Vector2i(6, 4),
		Vector2i(6, 9),
		Vector2i(7, 0),
		Vector2i(7, 2),
		Vector2i(7, 5),
		Vector2i(7, 7),
		Vector2i(7, 9),
		Vector2i(8, 1),
		Vector2i(8, 5),
		Vector2i(8, 8),
		Vector2i(8, 10),
		Vector2i(9, 2),
		Vector2i(9, 6),
		Vector2i(10, 1),
		Vector2i(10, 4),
		Vector2i(10, 8),
		Vector2i(10, 10),
		Vector2i(11, 11),
	],
	"h_haybale": [
		Vector2i(1, 0),
		Vector2i(3, 0),
		Vector2i(5, 0),
		Vector2i(9, 0),
		
		Vector2i(1, 11),
		Vector2i(3, 11),
		Vector2i(5, 11),
		Vector2i(7, 11),
		Vector2i(9, 11),
		
		Vector2i(4, 2),
		Vector2i(9, 3),
		Vector2i(2, 4),
		Vector2i(5, 6),
		Vector2i(1, 7),
		Vector2i(4, 9),
		Vector2i(8, 9),
	],
	"v_haybale": [
		Vector2i(0, 2),
		Vector2i(0, 4),
		Vector2i(0, 8),
		Vector2i(0, 10),
		
		Vector2i(11, 2),
		Vector2i(11, 4),
		Vector2i(11, 6),
		Vector2i(11, 8),
		Vector2i(11, 10),
		
		Vector2i(2, 2),
		Vector2i(7, 4),
		Vector2i(4, 7),
		Vector2i(9, 8),
	]
}

const LEVEL_3 = {
	"map_size": Vector2i(18, 18),
	"start": Vector2i(11, 14),
	"start_barrier": Vector2i(0, 1),
	"win": Vector2i(5, 1),
	#"win": Vector2i(1, 6),
	"win_barrier": Vector2i(0, -1),
	"pumkin": [
		Vector2i(4, 1),
		
		Vector2i(2, 2),
		Vector2i(6, 2),
		Vector2i(8, 2),
		Vector2i(10, 2),
		Vector2i(11, 2),
		Vector2i(15, 2),
		
		Vector2i(3, 3),
		Vector2i(6, 3),
		Vector2i(9, 3),
		
		Vector2i(7, 4),
		Vector2i(10, 4),
		Vector2i(13, 4),
		Vector2i(14, 4),
		
		Vector2i(5, 5),
		Vector2i(8, 5),
		Vector2i(11, 5),
		Vector2i(12, 5),
		Vector2i(15, 5),
		
		Vector2i(2, 6),
		Vector2i(4, 6),
		Vector2i(6, 6),
		Vector2i(11, 6),
		
		Vector2i(3, 7),
		Vector2i(8, 7),
		Vector2i(10, 7),
		Vector2i(11, 7),
		Vector2i(13, 7),
		
		Vector2i(2, 8),
		Vector2i(5, 8),
		Vector2i(7, 8),
		
		Vector2i(2, 9),
		Vector2i(4, 9),
		Vector2i(8, 9),
		Vector2i(10, 9),
		Vector2i(11, 9),
		Vector2i(13, 9),
		Vector2i(15, 9),
		
		Vector2i(3, 10),
		Vector2i(7, 10),
		Vector2i(8, 10),
		Vector2i(13, 10),
		
		Vector2i(4, 11),
		Vector2i(5, 11),
		Vector2i(11, 11),
		Vector2i(14, 11),
		
		Vector2i(3, 12),
		Vector2i(8, 12),
		
		Vector2i(2, 13),
		Vector2i(5, 13),
		Vector2i(7, 13),
		Vector2i(9, 13),
		Vector2i(12, 13),
		Vector2i(13, 13),
		Vector2i(15, 13),
		
		Vector2i(1, 14),
		Vector2i(10, 14),
		Vector2i(16, 14),
	],
	"h_haybale": [
		Vector2i(4, 0),
		
		Vector2i(2, 1),
		Vector2i(6, 1),
		Vector2i(8, 1),
		Vector2i(10, 1),
		Vector2i(12, 1),
		Vector2i(14, 1),
		
		Vector2i(4, 3),
		Vector2i(11, 3),
		Vector2i(3, 5),
		Vector2i(3, 8),
		Vector2i(13, 8),
		Vector2i(7, 6),
		Vector2i(8, 11),
		Vector2i(10, 12),
		
		Vector2i(2, 14),
		Vector2i(4, 14),
		Vector2i(6, 14),
		Vector2i(8, 14),
		Vector2i(12, 14),
		Vector2i(14, 14),
	],
	"v_haybale": [
		Vector2i(1, 3),
		Vector2i(1, 5),
		Vector2i(1, 7),
		Vector2i(1, 9),
		Vector2i(1, 11),
		Vector2i(1, 13),
		
		Vector2i(2, 5),
		Vector2i(9, 5),
		Vector2i(9, 9),
		Vector2i(13, 6),
		Vector2i(6, 10),
		Vector2i(12, 10),
		Vector2i(15, 12),
		Vector2i(4, 13),
		
		Vector2i(16, 3),
		Vector2i(16, 5),
		Vector2i(16, 7),
		Vector2i(16, 9),
		Vector2i(16, 11),
		Vector2i(16, 13),
	]
}
