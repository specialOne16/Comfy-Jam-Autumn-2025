extends Panel

@onready var menu_music: AudioStreamPlayer = AudioPlayer.menu_music
@onready var settings: Control = $Settings

func _ready() -> void:
	settings.visible = false
	settings.back_callback = func(): settings.visible = false
	Cutscene.stage = 0
	if not menu_music.playing:
		menu_music.play(6)

func _on_play_pressed() -> void:
	menu_music.stop()
	get_tree().change_scene_to_file("res://cutscene/cutscene.tscn")


func _on_settings_pressed() -> void:
	settings.visible = true
