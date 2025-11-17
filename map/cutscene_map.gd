extends Node2D

@onready var gameplay_music: AudioStreamPlayer = AudioPlayer.gameplay
@onready var player: Player = $Player
@onready var text_box: Textbox = $CanvasLayer/Control/TextBox
@onready var win_area: Area2D = $WinArea

const TEXT: Array[Array] = [
	["Serena", "Dang it! Where did she go?"],
	["Serena", "Looks like she left a trail."]
]

func _ready() -> void:
	if not gameplay_music.playing: gameplay_music.play(2)
	
	Player.looking = { "dir": "down", "flip": 1 }
	LevelsConfig.current_level = 0
	
	text_box.visible = false
	player.cutscene = true
	$CanvasLayer/InGameLayer.restart_button.modulate = Color.TRANSPARENT
	
	text_box.start(TEXT)
	text_box.finished.connect(
		func(_cutscene_name): player.cutscene = false
	)

func _process(_delta: float) -> void:
	if not player.cutscene:
		if Input.is_action_just_pressed("pause"): $CanvasLayer/InGameLayer._on_texture_button_pressed()


func _on_win_area_win_area_reached() -> void:
	call_deferred("open_map")

func open_map():
	get_tree().change_scene_to_file("res://map/map.tscn")


func _on_in_game_layer_pause(is_paused: bool) -> void:
	player.pause_game = is_paused
	text_box.paused = is_paused
	$CanvasLayer/Control.visible = not is_paused
