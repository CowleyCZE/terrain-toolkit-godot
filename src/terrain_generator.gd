extends Node3D

class_name TerrainGenerator

static func create_terrain(config: Dictionary) -> Node3D:
    var width: int = int(config.get("width", 256))
    var depth: int = int(config.get("depth", 256))
    var scale: float = float(config.get("scale", 1.0))
    var height_scale: float = float(config.get("height_scale", 50.0))
    var noise_type: String = String(config.get("noise_type", "perlin"))
    var seed: int = int(config.get("noise_seed", 0))
    var frequency: float = float(config.get("frequency", 0.02))
    var octaves: int = int(config.get("octaves", 3))
    var heightmap: Image
    if noise_type == "perlin":
        heightmap = HeightmapUtils.generate_heightmap_perlin(width, depth, seed, frequency, octaves)
    else:
        heightmap = HeightmapUtils.generate_heightmap_perlin(width, depth, seed, frequency, octaves)
    var mesh: ArrayMesh = MeshUtils.image_to_mesh(heightmap, height_scale, scale)
    var instance := MeshInstance3D.new()
    instance.mesh = mesh
    return instance

static func create_from_heightmap(image: Image, config: Dictionary) -> Node3D:
    var height_scale: float = float(config.get("height_scale", 50.0))
    var scale: float = float(config.get("scale", 1.0))
    var mesh: ArrayMesh = MeshUtils.image_to_mesh(image, height_scale, scale)
    var instance := MeshInstance3D.new()
    instance.mesh = mesh
    return instance

static func optimize_mesh(mesh: ArrayMesh, options: Dictionary) -> ArrayMesh:
    var lod_levels: int = int(options.get("lod_levels", 0))
    var target_reduction := options.get("target_reduction", [])
    return MeshUtils.optimize_mesh_lod(mesh, lod_levels, target_reduction)

static func paint_by_height(node: Node3D, config: Dictionary) -> void:
    var _layers := config.get("height_layers", [])
    pass
