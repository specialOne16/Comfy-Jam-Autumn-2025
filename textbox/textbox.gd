extends Control
class_name Textbox

var data: Array

@onready var speaker: Label = $Speaker
@onready var text: Label = $Text

var TYPING_SPEED: float = 0.02
var typing_speed: float = TYPING_SPEED

const SHOW_DELAY: float = 0.7
const FINISH_DELAY: float = 0.7

var typing_progress = 0
var typing_target = ""

var speaker_index = 0
var line: int = 0

signal finished(cutscene_name: String)
var cutscene_name = ""
var paused = false

func start(text_list: Array, _cutscene_name: String = ""):
	assert(not data)
	
	await get_tree().create_timer(SHOW_DELAY).timeout
	visible = true
	
	typing_speed = TYPING_SPEED
	speaker_index = 0
	line = 0
	
	data = text_list
	typing_progress = 0
	typing_target = data[speaker_index][1]
	cutscene_name = _cutscene_name


func _ready() -> void:
	visible = false


func _process(delta: float) -> void:
	if !data or paused: return
	
	typing_speed -= delta
	if typing_speed < 0:
		typing_speed = TYPING_SPEED
		typing_progress += 1
	
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("lmb"):
		if typing_progress < typing_target.length():
			typing_progress = typing_target.length()
		elif speaker_index < data.size() - 1:
			speaker_index += 1
			typing_progress = 0
			typing_target = data[speaker_index][1]
		else:
			visible = false
			await get_tree().create_timer(FINISH_DELAY).timeout
			data = []
			var temp = cutscene_name
			cutscene_name = ""
			finished.emit(temp)
			
	
	
	if typing_progress < typing_target.length() + 1:
		speaker.text = data[speaker_index][0]
		text.text = typing_target.left(typing_progress)
