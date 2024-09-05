extends Node2D

@export var target_tile: BaseTile

@onready var character: Character = $Character

func _on_play_pressed() -> void:
	character.move_right()

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
