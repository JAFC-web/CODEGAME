extends Area2D


func _on_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://lv_2.tscn")
	pass # Replace with function body.
