class_name Enemy
extends "res://entities/base.gd"

var player: Player = null

const SPEED: float = 30.0

enum State { IDLE, CHASE, ATTACK }
var state: State = State.IDLE
# TODO: Add a timer and when the timer runs out, turn the enemy to
# face the front direction (when the enemy is idle)

@onready var enemy: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_cooldown: Timer = $AttackCooldown
# TODO: Add attack animations
# TODO: Add death animation and check for 0 or less HP
# TODO: Some enemies might want to run away once they hit low enough HP
# TODO: Create enemy stats object
var health: int = 100
var attack_damage: int = 10

var current_direction: Direction = Direction.DOWN


func _physics_process(_delta: float) -> void:
	if state == State.CHASE or state == State.ATTACK:
		chase()
		return
		
	if health <= 0:
		self.queue_free()
	
	idle()


func _on_detection_area_body_entered(body: Node2D) -> void:
	# When the player enters the zone, the enemy will chase it.
	player = body
	state = State.CHASE


func _on_detection_area_body_exited(_body: Node2D) -> void:
	# The enemy will stop chasing the player when they leave the detection area.
	player = null
	state = State.IDLE


func get_direction(offset: Vector2) -> Direction:
	if abs(offset.x) >= abs(offset.y):
		return Direction.RIGHT if offset.x >= 0 else Direction.LEFT
	
	return Direction.DOWN if offset.y >= 0 else Direction.UP
	

func chase() -> void:
	var offset: Vector2 = player.position - position
	position += offset / SPEED
	
	current_direction = get_direction(offset)
	enemy.flip_h = current_direction == Direction.LEFT
	enemy.play(WALK_ANIMATIONS[current_direction])
	

func idle() -> void:
	enemy.play(IDLE_ANIMATIONS[current_direction])


func is_enemy() -> void:
	pass


func attack() -> void:
	if state == State.ATTACK:
		print("Enemy is attacking!!")
		player.take_damage(attack_damage)


func _on_enemy_hit_box_body_entered(body: Node2D) -> void:
	if body.has_method("is_player"):
		state = State.ATTACK
		attack()
		attack_cooldown.start()


func _on_enemy_hit_box_body_exited(body: Node2D) -> void:
	if body.has_method("is_player"):
		state = State.CHASE
		attack_cooldown.stop()


func _on_attack_cooldown_timeout() -> void:
	attack()


func take_damage(damage_points: int) -> void:
	health -= damage_points
	print("Enemy hit!")
	print("Enemy HP: ", health)
