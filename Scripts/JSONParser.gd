extends Node

export(String) var file_name = ""

var passages: Array = []
var _parsed_json_object: Dictionary = {}
#var file_name = ""
func _ready():
	#file_name = ""
	_parsed_json_object = _load_json(file_name)
	print("filename: ", file_name)
	if _parsed_json_object.empty():
		return
		
	if _verify_twine(_parsed_json_object):
		_to_passages(_parsed_json_object)
	
func _load_json(name: String) -> Dictionary:
	var file: File = File.new()
	var err = file.open("res://" + name, File.READ)
	if not err == OK:
		print("err: ", err)
		return {}
		
	var content: JSONParseResult = JSON.parse(file.get_as_text())
	if not content.error == OK:
		print("content error: ", content.error)
		return {}
		
	file.close()
	return content.result

func _verify_twine(json: Dictionary) -> bool:
	var key: String = "creator"
	if json.has(key):
		if json.get(key) == "Twine":
			return true
	return false
	
func _to_passages(json: Dictionary):
	var psgs: Array = json.get("passages")
	
	for psg in psgs:
		var entry: Passage = Passage.new()
		var chunkOfText = _strip_links_from_text(psg.get("text"))
		var splitResult =  splitNameAndText(chunkOfText)
		entry.character = splitResult[0]
		entry.text = splitResult[1]
		entry.pid = psg.get("pid")
		if psg.has("links"):
			for lnk in psg.get("links"):
				var link_entry = PassageLink.new()
				link_entry.text = lnk.name
				link_entry.pid = lnk.pid
				entry.links.append(link_entry)
				
		passages.append(entry)
		
	print(passages)
	
func _strip_links_from_text(text: String) -> String:
	var start_index = text.find("[[")
	var clip = text.substr(start_index)
	return text.rstrip(clip)

func splitNameAndText(text:String) -> Array:
	var expression = "neutral"
	var end = text.find("))")
	var dialogue = text.substr(end)
	var start = 2
	var name = text.substr(start)
	name = name.rstrip(dialogue)
	dialogue = dialogue.lstrip(")) ")
	var expressionIndex = name.find("_")
	if expressionIndex == -1:
		expression = name.substr(expressionIndex)
	else:
		expression = "neutral"
	name = name.rstrip(expression)
	name = name.rstrip("_")
	print(name, dialogue, expression)
	var arrayOfText = [name, dialogue, expression]
	return arrayOfText
















