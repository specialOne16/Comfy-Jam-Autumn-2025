extends Node2D

@onready var gameplay_music: AudioStreamPlayer = AudioPlayer.gameplay

func _ready() -> void:
	if not gameplay_music.playing: gameplay_music.play()
