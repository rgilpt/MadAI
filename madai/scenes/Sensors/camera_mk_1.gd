@tool
extends Node2D

@onready var collision_shape_2d: CollisionShape2D = $Perception/CollisionShape2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D

@export var range: float = 1.0 :
	set(value):
		range = value
		if collision_shape_2d != null:
			collision_shape_2d.shape.radius = range

func _ready() -> void:
	collision_shape_2d.shape.radius = range


func _on_perception_body_entered(body: Node2D) -> void:
	if body.is_in_group("Collect") or body.is_in_group("ChangeLevel"):
		ray_cast_2d.target_position = body.global_position - ray_cast_2d.global_position
