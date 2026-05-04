class_name Player
extends "res://entities/base.gd"

var enemy: Enemy = null

const SPEED: float = 100.0

@onready var attack_cooldown: Timer = $AttackCooldown
# TODO: Add attack animations

# TODO: Create a player stats object
var health: int = 100
var attack_damage: int = 20

var current_direction: Direction = Direction.DOWN

const VELOCITIES: Dictionary[Direction, Vector2] = {
	Direction.UP: Vector2(0, -SPEED),
	Direction.DOWN: Vector2(0, SPEED),
	Direction.LEFT: Vector2(-SPEED, 0),
	Direction.RIGHT: Vector2(SPEED, 0),
}

const ACTION_DIRECTIONS: Dictionary[String, Direction] = {
	"ui_up": Direction.UP,
	"ui_down": Direction.DOWN,
	"ui_left": Direction.LEFT,
	"ui_right": Direction.RIGHT,
}

func _ready() -> void:
	play_animation(get_animation_name(IDLE_ANIMATIONS))


func _physics_process(delta: float) -> void:
	player_movement(delta)


func player_movement(_delta: float) -> void:
	for action: String in ACTION_DIRECTIONS:
		if Input.is_action_pressed(action):
			move(action)
			return
		
	idle()


func play_animation(animation_name: String) -> void:
	var animation: AnimatedSprite2D = $AnimatedSprite2D
	animation.flip_h = current_direction == Direction.LEFT
	animation.play(animation_name)
	

func get_animation_name(direction_dict: Dictionary[Direction, String]) -> String:
	return str(direction_dict.get(current_direction))


func idle() -> void:
	velocity = Vector2.ZERO
	play_animation(get_animation_name(IDLE_ANIMATIONS))
	move_and_slide()


func move(action: String) -> void:
	current_direction = ACTION_DIRECTIONS[action]
	velocity = VELOCITIES[current_direction]
	play_animation(get_animation_name(WALK_ANIMATIONS))
	move_and_slide()


func is_player() -> void:
	pass


func attack() -> void:
	print("Player is attacking!!!")
	enemy.take_damage(attack_damage)
	attack_cooldown.start()


func _on_player_hit_box_body_entered(body: Node2D) -> void:
	if body.has_method("is_enemy"):
		enemy = body
		attack()


func _on_player_hit_box_body_exited(body: Node2D) -> void:
	if body.has_method("is_enemy"):
		enemy = null
		attack_cooldown.stop()


func take_damage(damage_points: int) -> void:
	health -= damage_points
	print("Player hit!")
	print("Player HP: ", health)
