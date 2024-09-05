extends Node
	
var current_scene: Node = null

func win() -> void:
	print_debug("you win!")

func oops() -> void:
	print_debug("you loose!")

func go_to_menu():
	goto_scene("res://scene/ui/menu.tscn")

func go_to_l1():
	goto_scene("res://scene/level/level1.tscn")
	
func go_to_l2():
	goto_scene("res://scene/level/level2.tscn")
	
func go_to_l3():
	goto_scene("res://scene/level/level3.tscn")

func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu"):
		go_to_menu()

func _deferred_goto_scene(path):
	# It is now safe to remove the current scene.
	current_scene.free()
	var scene = ResourceLoader.load(path)
	# Instance the new scene.
	current_scene = scene.instantiate()
	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)
	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
