extends StaticBody2D

@export var hp := 30

func apply_hit(dmg: int) -> void:
	hp -= dmg
	if hp <= 0:
		queue_free()