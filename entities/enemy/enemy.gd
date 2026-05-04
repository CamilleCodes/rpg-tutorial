extends CharacterBody2D


const SPEED: float = 30.0

var player: Node2D = null

enum State { IDLE, CHASE }
var state: State = State.IDLE

@onready var enemy: AnimatedSprite2D = $AnimatedSprite2D

enum Direction { UP, DOWN, LEFT, RIGHT }
var current_direction: Direction = Direction.DOWN

const WALK_ANIMATIONS: Dictionary[Direction, String] = {
	Direction.UP: "back_walk",
	Direction.DOWN: "front_walk",
	Direction.LEFT: "side_walk",
	Direction.RIGHT: "side_walk",
}

const IDLE_ANIMATIONS: Dictionary[Direction, String] = {
	Direction.UP: "back_idle",
	Direction.DOWN: "front_idle",
	Direction.LEFT: "side_idle",
	Direction.RIGHT: "side_idle",
}


func _physics_process(_delta: float) -> void:
	if state == State.CHASE:
		chase()
	else:
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
