extends Node
class_name Noise

static func get_noise():
	randomize()
	var noise = OpenSimplexNoise.new()

	var new_seed = randi()
	#print('using seed %s' % new_seed)
	noise.seed = randi()

	return noise
