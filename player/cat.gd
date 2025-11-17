extends Node2D
class_name Cat

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func place(map_position: Vector2i):
	position = Vector2(
		map_position.x * LevelsConfig.BASE_TILE_SIZE.x, 
		map_position.y * LevelsConfig.BASE_TILE_SIZE.y
	)

func jump_away():
	AudioPlayer.cat_meow.play()
	animation_player.play("jump_away")
