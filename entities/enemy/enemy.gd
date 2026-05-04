extends CharacterBody2D


const SPEED: float = 30.0

var player: Node2D = null
var player_chase: bool = false


func _physics_process(_delta: float) -> void:
	if player_chase:
		position += (player.position - position)/SPEED
		
		$AnimatedSprite2D.play("side_walk")
		
		# TODO: Add the other directions (front vs back walk)
		if (player.position.x - position.x) < 0:
			# The enemy is going left
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		
	else:
		$AnimatedSprite2D.play("front_idle")


func _on_detection_area_body_entered(body: Node2D) -> void:
	# When the player enters the zone, the enemy will chase it.
	player = body
	player_chase = true


func _on_detection_area_body_exited(_body: Node2D) -> void:
	# The enemy will stop chasing the player when they leave the detection area.
	player = null
	player_chase = false
