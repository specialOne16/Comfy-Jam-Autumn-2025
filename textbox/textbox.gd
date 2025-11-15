extends Control
class_name Textbox

var data: Array

@onready var speaker: Label = $Speaker
@onready var text: Label = $Text

const TYPING_SPEED: float = 0.05
var typing_speed: float = TYPING_SPEED

const SHOW_DELAY: float = 0.7
var show_delay = SHOW_DELAY

var typing_progress = 0
var typing_target = ""

var speaker_index = 0
var line: int = 0

signal finished

func start(text_list: Array):
	data = text_list
	typing_progress = 0
	typing_target = data[speaker_index][1] + "                    "


func _ready() -> void:
	visible = false


func _process(delta: float) -> void:
	if !data: return
	
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
		await get_tree().create_timer(0.7).timeout
		finished.emit()
