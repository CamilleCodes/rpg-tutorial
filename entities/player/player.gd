class_name Player
extends "res://entities/base.gd"

var enemy: Enemy = null

enum State { IDLE, ATTACK }
var state: State = State.IDLE

const SPEED: float = 100.0

@onready var attack_cooldown: Timer = $AttackCooldown

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
	if state != State.ATTACK:
		player_movement(delta)

	attack()


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
	if Input.is_action_just_pressed("player_attack"):
		state = State.ATTACK
		play_animation(get_animation_name(ATTACK_ANIMATIONS))
		damage_enemy()


func _on_player_hit_box_body_entered(body: Node2D) -> void:
	if body is Enemy:
		enemy = body


func _on_player_hit_box_body_exited(body: Node2D) -> void:
	if body is Enemy:
		enemy = null


func take_damage(damage_points: int) -> void:
	health -= damage_points
	
	var message: String = "[color=green][b]Player hit with {0} points of damage!![/b][/color]"
	message = message.format([str(damage_points)])
	print_rich(message)
	print("Player HP: ", health)


func _on_attack_cooldown_timeout() -> void:
	attack_cooldown.stop()
	state = State.IDLE


func damage_enemy() -> void:
	if not enemy:
		return
	
	print("Player: I stab thee!")
	
	var message: String = "[color=white][b]Player attacks for {0} points of damage!![/b][/color]"
	message = message.format([str(attack_damage)])
	print_rich(message)
	
	enemy.take_damage(attack_damage)
	attack_cooldown.start()


func _on_animated_sprite_2d_animation_finished() -> void:
	if state == State.ATTACK:
		state = State.IDLE
