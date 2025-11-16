extends Control
class_name Textbox

var data: Array

@onready var speaker: Label = $Speaker
@onready var text: Label = $Text

var TYPING_SPEED: float = 0.02
var typing_speed: float = TYPING_SPEED

const SHOW_DELAY: float = 0.7
var show_delay = SHOW_DELAY

const FINISH_DELAY: float = 0.7
var finish_delay = FINISH_DELAY

var typing_progress = 0
var typing_target = ""

var speaker_index = 0
var line: int = 0

signal finished(cutscene_name: String)
var cutscene_name = ""
var paused = false

func start(text_list: Array, _cutscene_name: String = ""):
	assert(not data)
	
	typing_speed = TYPING_SPEED
	show_delay = SHOW_DELAY
	finish_delay = FINISH_DELAY
	speaker_index = 0
	line = 0
	
	data = text_list
	typing_progress = 0
	typing_target = data[speaker_index][1] + "                    "
	cutscene_name = _cutscene_name


func _ready() -> void:
	visible = false


func _process(delta: float) -> void:
	if !data or paused: return
	
	if show_delay > 0: 
		show_delay -= delta
		return
	else: 
		visible = true
	
	typing_speed -= delta
	if typing_speed < 0:
		typing_speed = TYPING_SPEED
		typing_progress += 1
	
	if typing_progress < typing_target.length() + 1:
		speaker.text = data[speaker_index][0]
		text.text = typing_target.left(typing_progress)
	elif speaker_index < data.size() - 1:
		speaker_index += 1
		typing_progress = 0
		typing_target = data[speaker_index][1] + "                    "
	else:
		visible = false
		if finish_delay > 0: 
			finish_delay -= delta
		else:
			data = []
			var temp = cutscene_name
			cutscene_name = ""
			finished.emit(temp)
