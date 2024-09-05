class_name LaderTile extends BaseTile

@onready var target_up: Marker2D = $TargetUp

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Character:
		var character := body as Character
		character.stop()
		character.climb(target_up.global_position / current_scale)
