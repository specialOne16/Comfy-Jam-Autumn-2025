extends Node2D

@onready var gameplay_music: AudioStreamPlayer = AudioPlayer.gameplay
@onready var text_box: Control = $CanvasLayer/TextBox
@onready var speaker: Label = $CanvasLayer/TextBox/Speaker
@onready var text: Label = $CanvasLayer/TextBox/Text
@onready var player: Player = $Player

var text_delay = 1.0

const TYPING_SPEED: float = 0.03
var typing_speed: float = TYPING_SPEED
var typing_progress = 0
var typing_target = ""
var speaker_index = 0

const TEXT = [
	["Serena", "Dang it! Where did she go?"],
	["Serena", "Looks like she left a trail."]
]

func _ready() -> void:
	if not gameplay_music.playing: gameplay_music.play(2)
	text_box.visible = false
	player.cutscene = true


func  _process(delta: float) -> void:
	if text_delay > 0: 
		text_delay -= delta
		return
	else: 
		text_box.visible = true
		typing_target = TEXT[speaker_index][1] + "                    "
	
	typing_speed -= delta
	if typing_speed < 0:
		typing_speed = TYPING_SPEED
		typing_progress += 1
	
	if typing_progress < typing_target.length() + 1:
		speaker.text = TEXT[speaker_index][0]
		text.text = typing_target.left(typing_progress)
	elif speaker_index < TEXT.size() - 1:
		speaker_index += 1
		typing_progress = 0
		typing_target = TEXT[speaker_index][1] + "                    "
	else:
		text_box.visible = false
		player.cutscene = false
	
