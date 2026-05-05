extends Node2D


func _on_world_transition_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		GameState.location = GameState.Location.CLIFFS
		get_tree().call_deferred("change_scene_to_file", "res://areas/world.tscn")
