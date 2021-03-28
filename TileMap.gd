extends TileMap

enum TILES {
	INVALID = -1
	DIRT = 0
	GRASS = 1
	WATER = 2
	SAND = 3
}

export (int) var width = 400
export (int) var height = 400

func _ready():
	randomize()

func generate_map():
	# get a new noise image
	# TODO noise configuration
	var new_noise : OpenSimplexNoise = Noise.get_noise()

	# for every pixel, generate a tile
	for x in range(width):
		for y in range(height):
			# get pixel from noise image
			# NOTE Added magic numbers as an offset, because the origin (0, 0) of OpenSimplex seems to favor zero.
			var pixel = new_noise.get_noise_2d(x + 3, y + 3)
			# determine which tile the pixel represents
			var tile_index = pixel_to_tile_index(pixel)
			# put tile onto map
			set_cell(x, y, tile_index)

# pixel should range between -1 and 1
# this function is responsible for making sense of the noise
func pixel_to_tile_index(pixel : float):
	# we will treat noise as mountains and valleys
	# each tile will have a maximum height, and tiles will default to an empty tile

	var max_water_level = -0.25
	var max_sand_level = -0.2
	var max_dirt_level = -0.1
	var max_grass_level = 1


	if pixel > -1 and pixel <= max_water_level:
		return TILES.WATER
	elif pixel > max_water_level and pixel <= max_sand_level:
		return TILES.SAND
	elif pixel > max_sand_level and pixel <= max_dirt_level:
		return TILES.DIRT
	elif pixel > max_dirt_level and pixel <= max_grass_level:
		return TILES.GRASS
	else:
		return TILES.INVALID
