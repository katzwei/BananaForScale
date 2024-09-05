class_name Character
extends CharacterBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var floor_target: Marker2D = $FloorTarget
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
#@onready var collision_cast: RayCast2D = $CollisionCast
#@onready var target_cast: RayCast2D = $TargetCast
var target_position := Vector2.ZERO
var direction := Vector2.ZERO
var stopped := false
var climbing := false

const SPEED = 100.0

func turn_on() -> void:
	if stopped:
		stopped = false
		set_process(!stopped)

func stop() -> void:
	#global_position.x = target_position.x
	#target_position = Vector2.ZERO
	stopped = true
	set_process(!stopped)
	animated_sprite_2d.play("default")
	
func move(vector: Vector2) -> void:
	turn_on()
	direction = vector

func move_up() -> void:
	move(Vector2(0.0, -1.0))
	
func move_right() -> void:
	move(Vector2(1.0, 0.0))
	
func move_down() -> void:
	move(Vector2(0.0, 1.0))
	
func move_left() -> void:
	move(Vector2(-1.0, 0.0))

#func move(direction: Vector2) -> void:
	#turn_on()
	#target_position = vector

func climb(vector: Vector2) -> void:
	target_position = vector
	climbing = true
	collision_shape_2d.set_deferred("disabled", true)
	move_up()

#func acquire_target() -> void:
	#turn_on()
	#if target_cast.is_colliding():
		#var new_position = target_cast.get_collision_point()
		#new_position.y = floor_target.global_position.y
		#target_position = new_position
		#if collider is BaseTile:
			#target_position = collider.target.global_position

#func _ready() -> void:
	#acquire_target()

func rescale(new_scale: float) -> void:
	#var collision_cast_scale = collision_cast.scale 
	#var target_cast_scale = target_cast.scale
	scale = Vector2(scale.x * new_scale, scale.y * new_scale)
	#collision_cast.scale = collision_cast_scale / new_scale
	#target_cast.scale = target_cast_scale / new_scale
	

func _process(delta: float) -> void:
	velocity = SPEED * delta * direction
	var animation = "default"
	if velocity != Vector2.ZERO:
		if climbing:
			animation = "climb"
			if floor_target.global_position.y <= target_position.y:
				climbing = false
				collision_shape_2d.set_deferred("disabled", false)
				move_right()
		else:
			animation = "walk"
	animated_sprite_2d.play(animation)
	var collision = move_and_collide(velocity)
	if collision:
		stop()
	#global_position += velocity
	#move_and_slide()

#func _process(delta: float) -> void:
	#var animation = "default"
	##if collision_cast.is_colliding():
		##target_position = floor_target.global_position
	##print_debug(ceilf(floor_target.global_position.x))
	##print_debug(ceilf(floor_target.global_position.y))
	#if ceilf(floor_target.global_position.x) > ceilf(target_position.x) || ceilf(floor_target.global_position.y) < ceil(target_position.y):
		##print_debug(floor_target.global_position)
		##print_debug(target_position)
		#animation = "default"
		#target_position = Vector2.ZERO
		#if climbing:
			#climbing = false
		##acquire_target()
	#elif target_position != Vector2.ZERO:
		#if climbing:
			#animation = "climb"
			#global_position.y -= SPEED * delta
		#else:
			#velocity = target_position * SPEED * delta
			#if velocity.x > 1.0:
				#animation = "walk"
			#if velocity.x > 10.0:
				#animation = "run"
			#move_and_slide()
	#animated_sprite_2d.play(animation)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	Global.oops()
