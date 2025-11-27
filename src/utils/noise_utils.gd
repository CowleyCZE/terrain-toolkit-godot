extends Node

class_name NoiseUtils

static func make_noise(seed: int, frequency: float, octaves: int, noise_type: String) -> FastNoiseLite:
    var noise := FastNoiseLite.new()
    noise.seed = seed
    noise.frequency = frequency
    noise.fractal_octaves = octaves
    if noise_type == "perlin":
        noise.noise_type = FastNoiseLite.NOISE_TYPE_PERLIN
    elif noise_type == "simplex":
        noise.noise_type = FastNoiseLite.NOISE_TYPE_SIMPLEX
    else:
        noise.noise_type = FastNoiseLite.NOISE_TYPE_PERLIN
    return noise

