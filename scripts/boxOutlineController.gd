extends Sprite2D

const OUTLINE_SHADER = preload("res://Shaders/outlineShader.tres")
const HIDDEN_SHADER = preload("res://Shaders/hiddenShader.tres")

func _on_area_2d_mouse_entered() -> void:
	self.set_deferred("material",OUTLINE_SHADER) 

func _on_area_2d_mouse_exited() -> void:
	self.set_deferred("material",HIDDEN_SHADER) 
