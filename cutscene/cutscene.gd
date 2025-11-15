extends Control
class_name Cutscene

@onready var cutscene_music: Array[AudioStreamPlayer] = [AudioPlayer.cutscene_1, AudioPlayer.cutscene_2]

static var stage: int = 0
static var page: int = 0
const CONFIG: Array[Array] = [
	[
		"I can't find her anywhere...",
		"hm... not here",
		"not here either",
		"that's weird",
		"Not even here...",
		"Maybe she got out...?",
		"I should go check",
		"Hey! Wait!"
	],
	[
		"There you are!",
		"Oh, did you make a friend?",
		"Aw, how cute!",
		"Gotcha!",
		"Sorry! Has ____ been causing trouble for you?",
		"No! Not at all!"
	]
]

@onready var label: Label = $Label

const TYPING_SPEED: float = 0.05
var typing_speed: float = TYPING_SPEED
var typing_progress = 0
var typing_target = ""


func _ready() -> void:
	typing_target = CONFIG[stage][page]
	typing_progress = 0
	
	if not cutscene_music[stage].playing:
		cutscene_music[stage].play()


func _process(delta: float) -> void:
	typing_speed -= delta
	if typing_speed < 0:
		typing_speed = TYPING_SPEED
		typing_progress += 1
	
	if typing_progress < typing_target.length() + 1:
		label.text = typing_target.left(typing_progress)
	else:
		await get_tree().create_timer(0.3).timeout
		page += 1
		if page < CONFIG[stage].size():
			get_tree().reload_current_scene()
		else:
			cutscene_music[stage].stop()
			
			page = 0
			stage += 1
			if stage < CONFIG.size():
				get_tree().change_scene_to_file("res://map/cutscene_map.tscn")
			else:
				stage = 0
				get_tree().change_scene_to_file("res://menu/main/main.tscn")
