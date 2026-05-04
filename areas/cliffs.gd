extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_world_transition_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		GameState.location = GameState.Location.CLIFFS
		get_tree().call_deferred("change_scene_to_file", "res://areas/world.tscn")
