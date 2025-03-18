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

var health : int = 100:
	set(value):
		health = clamp(value,0,100)
		if health <= 0:
			get_tree().quit()

var noteDelay = 550
var keyData = {}
var notesTable = {}
var currentTime = 0

signal HitNote
signal Miss

func _colour_notes(type = null):
	match type:
		"red":
			for note in get_children():
				if note is KeyNote:
					note.actualColour = Color("#ff0000")
					note.get_node("Sprite").modulate = Color("#ff0000")
		_:
			for note in get_children():
				if note is KeyNote:
					note.actualColour = note.noteColour
					note.get_node("Sprite").modulate = Color("#ffff61")
			

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
	Miss.connect(_on_miss_note)
	noteBarriar.area_entered.connect(_note_barriar_area)

func spawnNote(noteData):
	var newKey = key.instantiate()
	newKey.position.y = noteSpawn.position.y
	
	var keyNote = get_node("KeyNote" + str(noteData["id"]))
	var keySprite : Sprite2D = newKey.get_node("Sprite")
	
	newKey.direction = keyNote.direction
	newKey.position.x = keyNote.position.x
	keySprite.modulate = keyNote.actualColour
	keySprite.rotation = keyNote.get_node("Sprite").rotation
	add_child(newKey)

func _note_barriar_area(area):
	if area is Key:
		area.queue_free()
		emit_signal("Miss",area.direction)

func _on_hit_note(direction):
	health += 3
	if playerSprite:
		playerSprite.play_anim(direction)

func _on_miss_note(direction):
	health -= 20
