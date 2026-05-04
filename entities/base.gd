extends CharacterBody2D

enum Direction { UP, DOWN, LEFT, RIGHT }

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

const ATTACK_ANIMATIONS: Dictionary[Direction, String] = {
	Direction.UP: "back_attack",
	Direction.DOWN: "front_attack",
	Direction.LEFT: "side_attack",
	Direction.RIGHT: "side_attack",
}
