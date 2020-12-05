extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene("res://Scenes/Level8.tscn")
	pass # Replace with function body.
	
func _on_DEATH_body_entered(body):
	if body.is_in_group("player"):
		get_tree().reload_current_scene()
	pass # Replace with function body.
