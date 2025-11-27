extends Node

class_name HeightmapUtils

static func generate_heightmap_perlin(width: int, depth: int, seed: int, frequency: float, octaves: int) -> Image:
    var noise := FastNoiseLite.new()
    noise.noise_type = FastNoiseLite.NOISE_TYPE_PERLIN
    noise.seed = seed
    noise.frequency = frequency
    noise.fractal_octaves = octaves
    var img := Image.create(width, depth, false, Image.FORMAT_RF)
    img.lock()
    for y in range(depth):
        for x in range(width):
            var nx := float(x) / float(width)
            var ny := float(y) / float(depth)
            var v := noise.get_noise_2d(x, y)
            var n := (v + 1.0) * 0.5
            img.set_pixel(x, y, Color(n, 0.0, 0.0, 1.0))
    img.unlock()
    return img

