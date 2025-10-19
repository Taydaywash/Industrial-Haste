extends Node2D



func _on_tool_clicked(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if(event.InputEventMouseButton == MOUSE_BUTTON_LEFT):
		print(viewport)
		print(event)
		print(shape_idx)
	
