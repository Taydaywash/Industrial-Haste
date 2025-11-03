extends Node2D

var holdingTool: bool = false
var heldTool: int = 0

@onready var tapeToolHeldSprite: Sprite2D = $TapeTool/TapeToolHeldSprite
@onready var wrenchToolHeldSprite: Sprite2D = $WrenchTool/WrenchToolHeldSprite
@onready var boltsToolHeldSprite: Sprite2D = $BoltsTool/BoltsToolHeldSprite

@onready var tapeToolToolBar: Sprite2D = $TapeTool/TapeToolToolBar
@onready var wrenchToolToolBar: Sprite2D = $WrenchTool/WrenchToolToolBar
@onready var boltsToolToolBar: Sprite2D = $BoltsTool/BoltsToolToolBar

var toolList = []
var toolPositions = []
func _ready() -> void:
	toolList = [
		"Hand Tool",
		tapeToolHeldSprite,
		wrenchToolHeldSprite,
		boltsToolHeldSprite
	]
	toolPositions = [
		tapeToolToolBar,
		wrenchToolToolBar,
		boltsToolToolBar
	]
func _process(_delta: float):
	if holdingTool:
		toolList[heldTool].position = get_local_mouse_position()
	elif heldTool != 0:
		toolList[heldTool].position = toolPositions[heldTool - 1].position
		heldTool = 0

#On MouseUp
func _input(event):
	if event is InputEventMouseButton and !event.pressed || event.is_action_pressed("pause"):
		holdingTool = false

#var tool recieved from extra call argument in Area2D
func _on_tool_clicked(_viewport: Node, event: InputEvent, _shape_idx: int, toolNumber: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		holdingTool = true
		heldTool = toolNumber
		Global._set_tool_to(heldTool)
