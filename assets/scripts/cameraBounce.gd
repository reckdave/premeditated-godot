extends Camera2D

var bounceBeat = 4

func _ready() -> void:
	%Song.Beat.connect(_on_beat)

func _on_beat(beat):
	if beat == bounceBeat:
		zoom = Vector2(1.1,1.1)
		var tween = get_tree().create_tween()
		tween.tween_property(self,"zoom",Vector2(1,1),.8)
