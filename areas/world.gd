extends Node2D


@onready var player: Player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GameState.location == GameState.Location.CLIFFS:
		player.position = Vector2(560, 131)
		GameState.location = GameState.Location.WORLD


func _on_cliffs_transition_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().call_deferred("change_scene_to_file", "res://areas/cliffs.tscn")
