extends Node2D

var holdingTool: bool = false
var heldTool: int = 0

@onready var tapeToolHeldSprite: Sprite2D = $TapeTool/TapeToolHeldSprite

@onready var tapeToolToolBar: Sprite2D = $TapeTool/TapeToolToolBar


var toolList = []

func _ready() -> void:
	toolList = [
		"Hand Tool",
		tapeToolHeldSprite
	]

func _process(_delta: float):
	if holdingTool:
		toolList[heldTool].position = get_local_mouse_position()
	elif heldTool != 0:
		toolList[heldTool].position = tapeToolToolBar.position
		heldTool = 0
		Global._set_tool_to(heldTool)

#On MouseUp
func _input(event):
	if event is InputEventMouseButton and !event.pressed:
		holdingTool = false

#var tool recieved from extra call argument in Area2D
func _on_tool_clicked(_viewport: Node, event: InputEvent, _shape_idx: int, toolNumber: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		holdingTool = true
		heldTool = toolNumber
		Global._set_tool_to(heldTool)
	
