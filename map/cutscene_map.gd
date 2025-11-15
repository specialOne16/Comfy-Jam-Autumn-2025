extends Node2D

@onready var gameplay_music: AudioStreamPlayer = AudioPlayer.gameplay
@onready var player: Player = $Player
@onready var text_box: Textbox = $CanvasLayer/TextBox
@onready var win_area: Area2D = $WinArea

const TEXT: Array[Array] = [
	["Serena", "Dang it! Where did she go?"],
	["Serena", "Looks like she left a trail."]
]

func _ready() -> void:
	if not gameplay_music.playing: gameplay_music.play(2)
	text_box.visible = false
	player.cutscene = true
	
	text_box.start(TEXT)
	text_box.finished.connect(
		func(_cutscene_name): player.cutscene = false
	)


func _on_win_area_win_area_reached() -> void:
	get_tree().change_scene_to_file("res://map/map.tscn")
