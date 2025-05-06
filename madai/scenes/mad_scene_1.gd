extends Node2D
@onready var mad_fox_bot: CharacterBody2D = $MadFoxBot

@onready var next_level: StaticBody2D = $MapFeatures/NextLevel

func _ready() -> void:
	
	#add next level location
	mad_fox_bot.memory_locations.add_memory(next_level.global_position, 
		mad_fox_bot.memory_locations.Types.CHANGE_LEVEL, next_level)
	
	#add all keys
	for c in $Keys.get_children():
		mad_fox_bot.memory_locations.add_memory(
			c.global_position, 
			mad_fox_bot.memory_locations.Types.KEY, 
			c)
