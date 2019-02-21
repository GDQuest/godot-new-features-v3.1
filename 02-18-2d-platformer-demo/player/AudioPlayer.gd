extends AudioStreamPlayer2D


func play_sound(_stream: AudioStreamSample) -> void:
	stream = _stream
	play()