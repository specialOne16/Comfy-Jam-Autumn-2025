extends Node

@onready var menu_music: AudioStreamPlayer = $MenuMusic
@onready var gameplay: AudioStreamPlayer = $Gameplay
@onready var cutscene_1: AudioStreamPlayer = $Cutscene1
@onready var cutscene_2: AudioStreamPlayer = $Cutscene2
@onready var footstep: AudioStreamPlayer = $Footstep
@onready var pumpkin: Array[AudioStreamPlayer] = [$Pumpkin2, $Pumpkin4]
