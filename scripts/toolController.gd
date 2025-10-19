extends Node2D

var holdingTool: bool = false
var heldTool: int = 0

@onready var toolOneHeldSprite: Sprite2D = $ToolOne/ToolOneHeldSprite

func _process(delta: float):
	pass

#On MouseUp
func _input(event):
	if event is InputEventMouseButton and !event.pressed:
		holdingTool = false
		heldTool = 0
		print("Unclick")

#var tool recieved from extra call argument in Area2D
func _on_tool_clicked(_viewport: Node, event: InputEvent, _shape_idx: int, toolNumber: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		holdingTool = true
		heldTool = toolNumber
		print("Clicked tool #" + str(heldTool))
	
