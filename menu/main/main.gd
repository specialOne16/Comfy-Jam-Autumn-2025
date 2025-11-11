extends Panel

@onready var menu_music: AudioStreamPlayer = AudioPlayer.menu_music

func _ready() -> void:
	if not menu_music.playing:
		AudioPlayer.menu_music.play()

func _on_play_pressed() -> void:
	AudioPlayer.menu_music.stop()
	get_tree().change_scene_to_file("res://cutscene/cutscene.tscn")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/settings/settings.tscn")
