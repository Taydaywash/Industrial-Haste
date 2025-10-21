extends Node

var tool = 0

func _set_tool_to(input):
	tool = input

func _get_tool():
	return tool

func _reset_tool():
	tool = 0
