extends Control
class_name Cutscene

@onready var cutscene_music: Array[AudioStreamPlayer] = [AudioPlayer.cutscene_1, AudioPlayer.cutscene_2]

@onready var texture_rect: TextureRect = $TextureRect
@onready var texture_rect_2: TextureRect = $TextureRect2
@onready var texture_rect_3: TextureRect = $TextureRect3

@onready var text_box: Textbox = $TextBox
@onready var speaker: Label = $TextBox/Speaker
@onready var text: Label = $TextBox/Text

const CONFIG: Array[Array] = [
	[
		{
			"image": preload("uid://c1x02oiy44oif"),
			"text": [
				["Serena", "Maple? Maple?"],
				["Serena", "I can’t find her anywhere…"],
				["Serena", "Hmmm. Where could she be?"],
				["Serena", "Perhaps in her cat tree?"],
			]
		},
		{
			"image": preload("uid://c7b586eqb6unb"),
			"flash_cat": preload("uid://boquhajumfj3r"),
			"text": [
				["Serena", "Huh? She’s not here…"],
				["Serena", "Where else could she be?"],
				["Serena", "Maybe she’s playing with her toys!"],
			]
		},
		{
			"image": preload("uid://c6jk85gmu0707"),
			"flash_cat": preload("uid://cldl2hpsvtqi7"),
			"text": [
				["Serena", "Not here either???"],
				["Serena", "Where is she?"],
				["Serena", "Is she mad at me? Did I forget to feed her?"],
			]
		},
		{
			"image": preload("uid://b2u3m3luygyrp"),
			"flash_cat": preload("uid://4u5q5jv5ndmc"),
			"text": [
				["Serena", "No, I definitely put food out for her."],
				["Serena", "It doesn’t look like she ate any. That’s unlike her."],
				["Serena", "Maybe she’s napping on the couch!"],
			]
		},
		{
			"image": preload("uid://dbbt3twasgitj"),
			"flash_cat": preload("uid://cjwxh5vinmol4"),
			"text": [
				["Serena", "What?"],
				["Serena", "She’s not here either?"],
				["Serena", "Did she get out somehow?"],
			]
		},
		{
			"image": preload("uid://c88aov0myebt2"),
			"text": [
				["Serena", "No sign of her…"]
			]
		},
		{
			"image": preload("uid://c88aov0myebt2"),
			"non_flash_cat": preload("uid://ns2jul6ucysq"),
			"text": [
				["Serena", "Wait! I see something!"]
			]
		},
		{
			"image": preload("uid://cac0cdpwfxc0t"),
			"text": [
				["Serena", "Maple?"]
			]
		},
		{
			"image": preload("uid://kvwvit3dw3vb"),
			"text": [
				["Serena", "Maple! No!"]
			]
		}
	],
	[
		{
			"image": preload("uid://c2udm0h3jbypb"),
			"text": [
				["Serena", "There you are!"],
				["Serena", "Please never do that again!"]
			]
		},
		{
			"image": preload("uid://epaowq03reoh"),
			"text": [
				["Serena", "Oh? Who’s this?"],
				["Serena", "Did you make a friend?"],
				["Serena", "Awww! Is this why you ran off?"]
			]
		},
		{
			"image": preload("uid://x3j5536pm5ku"),
			"text": [
				["Serena", "Aww Maple do you have a crush? So cute!"]
			]
		},
		{
			"image": preload("uid://bmadn12tmuf1o"),
			"text": [
				["Serena", "Gotcha!"]
			]
		},
		{
			"image": preload("uid://djfqfydb2mpb0"),
			"text": [
				["Serena", "Does this other kitty have an owner?"],
				["Serena", "Maybe you can come home with us too!"]
			]
		},
		{
			"image": preload("uid://bwylhnucr5b1f"),
			"text": [
				["Serena", "Oh hello!"]
			]
		},
		{
			#"image": ,
			"text": [
				["Vivian", "Hazel! There you are!"],
				["Serena", "Is this your cat?"],
				["Vivian", "Yeah! This is Hazel. She can be such a troublemaker!"],
				["Serena", "I think she might have lured my sweet Maple out of the house."],
				["Vivian", "Oh my goodness! I’m so sorry. I hope she didn’t cause you any trouble!"]
			]
		},
		{
			"image": preload("uid://ckesl5sondrh6"),
			"text": [
				["Serena", "No! Not at all!"],
				["Vivian", "Well I’m sorry for bothering you…Sorry what’s your name?"],
				["Serena", "It’s Serena!"],
				["Vivian", "What a beautiful name. I’m Vivian."],
				["Serena", "Thank you! I like yours too."],
				["Serena", "Anyways! We were just about to head back to my place."],
				["Vivian", "Oh alright. I don’t want to keep you out here in the cold!"],
				["Serena", "Well…Would you and Hazel like to come over?"],
				["Serena", "I have some hot chocolate and some treats at home."],
				["Vivian", "That sounds wonderful!"]
			]
		}
	]
]

static var stage: int = 0
static var page: int = 0

const BLINK_SPEED: float = 0.5
var blink_speed: float = BLINK_SPEED

func _ready() -> void:
	var data: Dictionary = CONFIG[stage][page]

	texture_rect.texture = data.image if data.has("image") else null
	texture_rect_2.texture = data.flash_cat if data.has("flash_cat") else null
	texture_rect_3.texture = data.non_flash_cat if data.has("non_flash_cat") else null
	
	if stage == 1: text_box.TYPING_SPEED = 0.04
	
	text_box.start(data.text)
	text_box.finished.connect(
		func(_cutscene_name): 
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
	)
	
	if not cutscene_music[stage].playing:
		cutscene_music[stage].play((stage + 2) % 3)


func _process(delta: float) -> void:
	if texture_rect_2.texture:
		blink_speed -= delta
		if blink_speed < 0:
			blink_speed = BLINK_SPEED
			texture_rect_2.visible = not texture_rect_2.visible
