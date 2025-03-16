extends AudioStreamPlayer
class_name GameSong

var bpm = 144.0
var beatTime = 60.0 / bpm
var time = 0.0
var beat : int = 0
var songBeat : int = 1
var prevBeat : int = 1

signal Beat

func _process(delta: float) -> void:
	if playing:
		time = get_playback_position()
		prevBeat = songBeat
		songBeat = time / beatTime
		_checkBeat()

func _checkBeat():
	if prevBeat != songBeat:
		beat += 1
		if beat > 4:
			beat = 1
		emit_signal("Beat",beat)
