extends Node2D
class_name NotesBase

@export var noteSpawn : Node2D
@export var noteBarriar : Area2D
@export var autohit : bool = false

@export var songNode : AudioStreamPlayer
@export_file("*.json") var chart

@export_enum("bf","dad") var notePlayer = "bf"
@export var playerSprite : Node2D

@onready var key = preload("res://assets/objects/key.tscn")

var noteDelay = 500
var keyData = {}
var notesTable = {}
var currentTime = 0

signal HitNote

func _getkeyData():
	var file = FileAccess.open(chart,FileAccess.READ)
	if file:
		keyData = str_to_var(file.get_as_text())
		if notePlayer == "bf":
			notesTable = keyData["strumLines"][1]["notes"]
		else:
			notesTable = keyData["strumLines"][0]["notes"]
	file.close()

func _process(delta: float) -> void:
	if songNode.playing:
		currentTime = songNode.get_playback_position() * 1000
		#songNode
		while notesTable.size() > 0 and notesTable[0]["time"] <= currentTime + noteDelay:
			var noteData = notesTable.pop_front()
			spawnNote(noteData)

func _ready() -> void:
	_getkeyData()
	HitNote.connect(_on_hit_note)
	noteBarriar.area_entered.connect(_note_barriar_area)

func spawnNote(noteData):
	var newKey = key.instantiate()
	newKey.position.y = noteSpawn.position.y
	
	var keyNote = get_node("KeyNote" + str(noteData["id"]))
	var keySprite : Sprite2D = newKey.get_node("Sprite")
	
	newKey.position.x = keyNote.position.x
	keySprite.modulate = keyNote.noteColour
	keySprite.rotation = keyNote.get_node("Sprite").rotation
	#region oldcode
	#match noteData["id"]:
		#0:
			#var keySprite : Sprite2D = newKey.get_node("Sprite")
			#var keyNote = get_node("KeyNote")
			#
			#newKey.position.x = keyNote.position.x
			#keySprite.modulate = keyNote.noteColour
			#keySprite.rotation = keyNote.get_node("Sprite").rotation
		#1:
			#var keySprite : Sprite2D = newKey.get_node("Sprite")
			#var keyNote = get_node("KeyNote2")
			#
			#newKey.position.x = keyNote.position.x
			#keySprite.modulate = keyNote.noteColour
			#keySprite.rotation = keyNote.get_node("Sprite").rotation
		#2:
			#var keySprite : Sprite2D = newKey.get_node("Sprite")
			#var keyNote = get_node("KeyNote3")
			#
			#newKey.position.x = keyNote.position.x
			#keySprite.modulate = keyNote.noteColour
			#keySprite.rotation = keyNote.get_node("Sprite").rotation
		#3:
			#var keySprite : Sprite2D = newKey.get_node("Sprite")
			#var keyNote = get_node("KeyNote4")
			#
			#newKey.position.x = keyNote.position.x
			#keySprite.modulate = keyNote.noteColour
			#keySprite.rotation = keyNote.get_node("Sprite").rotation
	#endregion
	add_child(newKey)
	#await get_tree().create_timer(noteDelay).timeout

func _note_barriar_area(area):
	if area is Key:
		area.queue_free()

func _on_hit_note(direction):
	if playerSprite:
		playerSprite.play_anim(direction)
