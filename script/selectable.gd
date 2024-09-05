class_name Selectable
extends Area2D

@export var node_to_select: BaseTile

#signal select(node: Node)
#signal unselect(node: Node)

var selected := false

func _unhandled_input(event: InputEvent) -> void:
	if selected && event.is_action_pressed("main_action"):
		selected = false
		node_to_select.hide_scale_slider()

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if !selected && event.is_action_pressed("main_action"):
		selected = true
		node_to_select.show_scale_slider()
