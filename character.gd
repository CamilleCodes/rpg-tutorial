extends Node

# Character stats.
@export var max_hp: int = 12
@export var strength: int = 8
@export var magic: int = 8

# Leveling system.
@export var level: int = 1

var experience: int = 0
var experience_total: int = 0
var experience_required: int = get_required_experience(level + 1)


func get_required_experience(lvl: int) -> int:
	return round(pow(lvl, 1.8) + lvl * 4 + 8)


func gain_experience(amount: int) -> void:
	experience_total += amount
	experience += amount
	
	while experience >= experience_required:
		experience -= experience_required
		level_up()
		

func level_up() -> void:
	level += 1
	experience_required = get_required_experience(level + 1)
	
	var stats: Array[String] = ["max_hp", "strength", "magic"]
	# Pick a stat randomly and increase it
	var random_stat = stats[randi() % stats.size()]
	set(random_stat, get(random_stat) + randi() % 4 + 2)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
