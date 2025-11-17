extends Node2D
class_name Map

const PUMKIN = preload("res://pumkin/pumkin.tscn")
const H_HAYBALE = preload("res://haybale/h_haybale.tscn")
const V_HAYBALE = preload("res://haybale/v_haybale.tscn")
const START_AREA = preload("uid://bwp1851e60qyy")
const WIN_AREA = preload("uid://brokmxqw14236")

@onready var cat: Cat = $Cat
@onready var player: Player = $Player
@onready var player_camera: Camera2D = $PlayerCamera
@onready var pause_camera: Camera2D = $PauseCamera
@onready var cut_scene_camera: Camera2D = $CutSceneCamera
@onready var gameplay_music: AudioStreamPlayer = AudioPlayer.gameplay
@onready var text_box: Textbox = $CanvasLayer/Control/TextBox
@onready var tree = get_tree()

var grid: Array[Array]
static var is_from_restart = false

const TEXT = [
	{
		#- Level 1 -
		"begin": [["Serena", "Maple?"]],
		#- Cat on haybale -
		"cutscene": {
			"text": [["Serena", "There she is!"]]
		},
		#- Return to Level 1 -
		"after_cutscene": [
			["Serena", "She ran into the pumpkin patch!"],
			["Serena", "Looks like I’m gonna have to make a path to get to her."],
			["Serena", "The haybales are too tall to climb over and too heavy to move."],
			["Serena", "I’ll have to push these pumpkins around."],
		],
		#- End of level - cat jumps off screen -
		"ending": {
			"text": [["Serena", "Hey! Come back here!"]]
		}
	},
	{
		#- Level 2 -
		"begin": [
			["Serena", "Maple! Please come back home!"],
			["Serena", "Why does this pumpkin patch seem to be getting bigger?"]
		],
		#- End of level - cat jumps off screen -
		"ending": {
			"text": [["Serena", "Maple please! It’s cold outside!"]]
		}
	},
	{
		#- Level 3 -
		"begin": [["Serena", "I’ll buy you new toys! I’ll get better cat food! Anything!"]]
	}
]

func _ready() -> void:
	var level_map = LevelsConfig.load_level(LevelsConfig.current_level + 1)
	
	if not level_map.has("map_size"):
		gameplay_music.stop()
		get_tree().change_scene_to_file("res://cutscene/cutscene.tscn")
		return
	
	grid.resize(LevelsConfig.map_size.x)
	for row in grid:
		row.resize(LevelsConfig.map_size.y)
	
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
	pause_camera.position = Vector2(level_map.map_size) / 2 * LevelsConfig.BASE_TILE_SIZE
	player_camera.position.x = pause_camera.position.x
	
	if not gameplay_music.playing: gameplay_music.play(2)
	
	if is_from_restart:
		is_from_restart = false
	else:
		play_cutscene()

func _process(_delta: float) -> void:
	player_camera.position.y = clampf(
		player.position.y,
		pause_camera.position.y - LevelsConfig.current_level * (1 + LevelsConfig.current_level) * 18,
		pause_camera.position.y + LevelsConfig.current_level * (1 + LevelsConfig.current_level) * 18,
	)
	
	if not player.cutscene:
		if Input.is_action_just_pressed("pause"): $CanvasLayer/InGameLayer._on_texture_button_pressed()
		if Input.is_action_just_pressed("restart"): _on_in_game_layer_restart()

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
	grid[start_position.x][start_position.y] = start_area
	start_area.barrier_direction = collision_direction
	start_area.position = Vector2(
		start_position.x * LevelsConfig.BASE_TILE_SIZE.x, 
		start_position.y * LevelsConfig.BASE_TILE_SIZE.y
	)
	player.place(start_position)
	add_child(start_area)
	
func _make_win_area(win_position: Vector2i, collision_direction: Vector2i):
	var win_area = WIN_AREA.instantiate()
	grid[win_position.x][win_position.y] = win_area
	win_area.barrier_direction = collision_direction
	win_area.position = Vector2(
		win_position.x * LevelsConfig.BASE_TILE_SIZE.x, 
		win_position.y * LevelsConfig.BASE_TILE_SIZE.y
	)
	win_area.win_area_reached.connect(
		func(): 
			cat.jump_away()
			play_cutscene("ending")
	)
	cat.place(win_position)
	cut_scene_camera.position = cat.position
	add_child(win_area)


func _on_in_game_layer_restart() -> void:
	if player.cutscene: return
	
	LevelsConfig.current_level -= 1
	is_from_restart = true
	get_tree().reload_current_scene()


func _on_in_game_layer_pause(is_paused: bool) -> void:
	player.pause_game = is_paused
	text_box.paused = is_paused
	$CanvasLayer/Control.visible = not is_paused
	if is_paused:
		pause_camera.make_current()
	else:
		player_camera.make_current()


func play_cutscene(cutscene_name: String = "begin"):
	var cutscene: Dictionary = TEXT[LevelsConfig.current_level - 1]
	player.cutscene = true
	match cutscene_name:
		"begin": text_box.start(cutscene["begin"], "begin")
		"ending":
			if TEXT.size() == LevelsConfig.current_level: call_deferred("to_cutscene")
			else: text_box.start(cutscene["ending"].text, "ending")
	
	text_box.finished.connect(
		func(finished_cutscene_name): 
			match finished_cutscene_name:
				"begin":
					if cutscene.has("cutscene"): 
						cut_scene_camera.make_current()
						text_box.start(cutscene.cutscene.text, "cutscene")
					else: player.cutscene = false
				"cutscene":
					player_camera.make_current()
					text_box.start(cutscene.after_cutscene, "after_cutscene")
				"after_cutscene":
					player.cutscene = false
				"ending":
					call_deferred("reload")
					
	)

func reload():
	tree.change_scene_to_file("res://map/map.tscn")

func to_cutscene():
	if gameplay_music.playing: gameplay_music.stop()
	tree.change_scene_to_file("res://cutscene/cutscene.tscn")
