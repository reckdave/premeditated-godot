extends Area2D
class_name Key

var direction = null

func _process(delta: float) -> void:
	if settings.downscroll:
		global_position -= Vector2(0,-settings.scrollspeed * delta * 450)
	else:
		global_position -= Vector2(0,settings.scrollspeed * delta * 450)
