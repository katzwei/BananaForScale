class_name PortalTile extends BaseTile

@export var exit_portal: PortalTile 

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Character && exit_portal:
		var character := body as Character
		character.stop()
		var ratio = false
		if exit_portal.current_scale < 1.0:
			var new_scale = fmod(1.0, exit_portal.current_scale)
			character.rescale(new_scale)
			#ratio = true
		var offset_y := character.floor_target.global_position.y - character.global_position.y
		#if ratio:
			#offset_y *= character.scale.y
		var new_y := exit_portal.target.global_position.y - offset_y
		var new_x := exit_portal.target.global_position.x
		character.global_position =  Vector2(new_x, new_y)
		character.move_right()
		#character.acquire_target()
