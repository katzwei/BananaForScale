class_name BaseTile
extends Node2D

@onready var target: Marker2D = $Target
@onready var scale_slider: HSlider = %ScaleSlider
@onready var tile_control: Control = $TileControl

@export var min_scale := .2
@export var max_scale := 2.0
@export var stating_scale := 1.0
@export var scaling_enabled := true

var selected = false
var current_scale = 1.0

func _ready() -> void:
	tile_control.scale = Vector2(stating_scale, stating_scale)
	scale_slider.visible = scaling_enabled

func show_scale_slider() -> void:
		scale_slider.visible = true
		
func hide_scale_slider() -> void:
		scale_slider.visible = false


func _on_scale_slider_value_changed(value: float) -> void:
	var new_scale := 1.0
	if value < 1.0:
		new_scale -= (1.0 - min_scale) * (1.0 - value)
	elif value > 1.0:
		new_scale += (max_scale - 1.0) * (value - 1.0)
	tile_control.scale = Vector2(new_scale, new_scale)
	current_scale = new_scale
	#print_debug(current_scale)
