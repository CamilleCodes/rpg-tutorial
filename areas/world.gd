extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_cliffs_transition_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().change_scene_to_file("res://areas/cliffs.tscn")


func _on_cliffs_transition_zone_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
