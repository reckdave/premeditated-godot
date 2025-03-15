extends Node2D
class_name KeyNote

@onready var keysprite : Sprite2D = $Sprite

@export_enum("left","down","up","right") var direction = "left"
@export var noteColour : Color
var actualColour : Color
#@export var direNum : int = 0

var areaInside = null

var pressed = false

func _ready() -> void:
	actualColour = noteColour

func _input(event: InputEvent) -> void:
	if get_parent().autohit: return
	if get_parent().notePlayer == "dad": return
	
	if event.is_action_pressed("arrow_" + direction):
		var tween = get_tree().create_tween()
		tween.tween_property(keysprite,"scale",Vector2(0.9,0.9),0.02)
		pressed = true
		if areaInside:
			areaInside.queue_free()
			get_parent().emit_signal("HitNote",direction)
	if event.is_action_released("arrow_" + direction):
		var tween = get_tree().create_tween()
		tween.tween_property(keysprite,"scale",Vector2(1,1),0.02)
		pressed = false



#region sick!
func _on_sick_area_area_entered(area: Area2D) -> void:
	if area is Key:
		areaInside = area
		if pressed or get_parent().autohit:
			areaInside.queue_free()
			get_parent().emit_signal("HitNote",direction)
func _on_sick_area_area_exited(area: Area2D) -> void:
	if area is Key:
		#areaInside = null
		pass
#endregion
