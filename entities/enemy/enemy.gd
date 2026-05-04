extends "res://entities/base.gd"

const SPEED: float = 30.0

var player: Node2D = null

enum State { IDLE, CHASE }
var state: State = State.IDLE

@onready var enemy: AnimatedSprite2D = $AnimatedSprite2D

var current_direction: Direction = Direction.DOWN


# TODO: Add a timer and when the timer runs out, turn the enemy to
# face the front direction (when the enemy is idle)

func _physics_process(_delta: float) -> void:
	if state == State.CHASE:
		chase()
		return
	
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
	pass


func _on_enemy_hit_box_body_entered(body: Node2D) -> void:
	if body.has_method("is_player"):
		print("The player is in attack range")


func _on_enemy_hit_box_body_exited(body: Node2D) -> void:
	if body.has_method("is_player"):
		print("The player is NOT in attack range")
