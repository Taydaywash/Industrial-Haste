extends Sprite2D

const OUTLINE_SHADER = preload("res://Shaders/outlineShader.tres")
const HIDDEN_SHADER = preload("res://Shaders/hiddenShader.tres")
@onready var tool_bar: Node2D = $"../../../ToolBar"

func _on_area_2d_mouse_entered() -> void:
	if tool_bar.holdingTool == true:
		self.set_deferred("material",OUTLINE_SHADER) 

func _on_area_2d_mouse_exited() -> void:
	self.set_deferred("material",HIDDEN_SHADER) 
