extends CharacterBody2D


const SPEED: float = 30.0

var player: Node2D = null
var player_chase: bool = false

@onready var enemy: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(_delta: float) -> void:
	if player_chase:
		position += (player.position - position)/SPEED
		
		enemy.play("side_walk")
		
		# TODO: Add the other directions (front vs back walk)
		if (player.position.x - position.x) < 0:
			# The enemy is going left
			enemy.flip_h = true
		else:
			enemy.flip_h = false
		
	else:
		enemy.play("front_idle")


func _on_detection_area_body_entered(body: Node2D) -> void:
	# When the player enters the zone, the enemy will chase it.
	player = body
	player_chase = true


func _on_detection_area_body_exited(_body: Node2D) -> void:
	# The enemy will stop chasing the player when they leave the detection area.
	player = null
	player_chase = false
