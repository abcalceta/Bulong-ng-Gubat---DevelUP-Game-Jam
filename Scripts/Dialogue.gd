extends Control

onready var _passages: Array = $JSONParser.passages
onready var _dialogue: Label = $Text
onready var _character: Label = $Name
onready var _option1_btn: Button = $VBoxContainer/Button
onready var _option2_btn: Button = $VBoxContainer/Button2
onready var _option3_btn: Button = $VBoxContainer/Button3
onready var _option4_btn: Button = $Continue

var _current_passage_index: int = 0

signal changeExpression(expression)
signal done

func _ready():
	_change_dialogue(_current_passage_index)
	
func _change_dialogue(index: int):
	_dialogue.text = _passages[index].text
	_character.text = _passages[index].character
	emit_signal("changeExpression", _passages[index].expression)
	# MAX 3 options 
	match _passages[index].links.size():
		1:
			_option1_btn.text = ""
			_option2_btn.text = ""
			_option3_btn.text = ""
			_option4_btn.text = "CONTINUE" #_passages[index].links[0].text
			
			_option1_btn.hide()
			_option2_btn.hide()
			_option3_btn.hide()
			_option4_btn.show()
		2:
			_option1_btn.text = _passages[index].links[0].text
			_option2_btn.text = _passages[index].links[1].text
			_option3_btn.text = ""
			_option4_btn.text = ""
			
			_option1_btn.show()
			_option2_btn.show()
			_option3_btn.hide()
			_option4_btn.hide()
		3:
			_option1_btn.text = _passages[index].links[0].text
			_option2_btn.text = _passages[index].links[1].text
			_option3_btn.text = _passages[index].links[2].text
			_option4_btn.text = ""
			
			_option1_btn.show()
			_option2_btn.show()
			_option3_btn.show()
			_option4_btn.hide()
		_:
			#Globals.stripDetailsFromDialogue(_dialogue.text)
			emit_signal("done")
			print("done")
			return
			
	_current_passage_index = index


func _on_Continue_pressed():
	var current_passage: Passage = _passages[_current_passage_index]
	var next_passage_pid: int = current_passage.links[0].pid
	var index: int = 0
	
	for psg in _passages:
		if psg.pid == next_passage_pid:
			_change_dialogue(index)
			return
		index += 1


func _on_Button_pressed():
	var current_passage: Passage = _passages[_current_passage_index]
	var next_passage_pid: int = current_passage.links[0].pid
	var index: int = 0
	
	for psg in _passages:
		if psg.pid == next_passage_pid:
			_change_dialogue(index)
			return
		index += 1

func _on_Button2_pressed():
	var current_passage: Passage = _passages[_current_passage_index]
	var next_passage_pid: int = current_passage.links[1].pid
	var index: int = 0
	
	for psg in _passages:
		if psg.pid == next_passage_pid:
			_change_dialogue(index)
			return
		index += 1
		
func _on_Button3_pressed():
	var current_passage: Passage = _passages[_current_passage_index]
	var next_passage_pid: int = current_passage.links[2].pid
	var index: int = 0
	
	for psg in _passages:
		if psg.pid == next_passage_pid:
			_change_dialogue(index)
			return
		index += 1


