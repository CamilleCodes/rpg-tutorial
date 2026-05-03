extends CharacterBody2D


const speed: float = 300.0

var current_direction: String = "none"

func _ready() -> void:
	$AnimatedSprite2D.play("down_idle")


func _physics_process(delta: float) -> void:
	player_movement(delta)


func player_movement(_delta: float) -> void:
	var animation_walk_dict: Dictionary[String, String] = {
		"up": "up_walk",
		"down": "down_walk",
		"left": "side_walk",
		"right": "side_walk",
	}

	var animation_idle_dict: Dictionary[String, String] = {
		"up": "up_idle",
		"down": "down_idle",
		"left": "side_idle",
		"right": "side_idle",
	}

	if Input.is_action_pressed("ui_right"):
		current_direction = "right"
		play_animation(get_animation_name(animation_walk_dict))
		
		velocity.x = speed
		velocity.y = 0
		
	elif Input.is_action_pressed("ui_left"):
		current_direction = "left"
		play_animation(get_animation_name(animation_walk_dict))
		
		velocity.x = -speed
		velocity.y = 0
		
	elif Input.is_action_pressed("ui_up"):
		current_direction = "up"
		play_animation(get_animation_name(animation_walk_dict))

		velocity.x = 0
		velocity.y = -speed
		
	elif Input.is_action_pressed("ui_down"):
		current_direction = "down"
		play_animation(get_animation_name(animation_walk_dict))

		velocity.x = 0
		velocity.y = speed
	
	else:
		play_animation(get_animation_name(animation_idle_dict))
		velocity.x = 0
		velocity.y = 0

	move_and_slide()


func play_animation(animation_name: String) -> void:
	var animation: AnimatedSprite2D = $AnimatedSprite2D
	animation.flip_h = current_direction == "left"
	animation.play(animation_name)
	

func get_animation_name(direction_dict: Dictionary[String, String]) -> String:
	return str(direction_dict.get(current_direction, "side_idle"))
