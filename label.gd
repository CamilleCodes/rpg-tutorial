extends Label

func update_text(level: int, experience: int, required_exp: int, total_exp: int) -> void:
	var experience_bar = "Level: {0}\nExperience/Next Level: {1}/{2}\nTotal Experience: {3}"
	text = experience_bar.format([level, experience, required_exp, total_exp])


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
