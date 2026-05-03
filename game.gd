extends Node


@onready var _character = $Character
@onready var _label = $Interface/Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_label.update_text(_character.level, _character.experience, 
		_character.experience_required, _character.experience_total)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	trigger_gain_experience()


func trigger_gain_experience() -> void:
	if not Input.is_action_pressed("increase_experience"):
		return
	
	_character.gain_experience(1)
	_label.update_text(_character.level, _character.experience, 
		_character.experience_required, _character.experience_total)
