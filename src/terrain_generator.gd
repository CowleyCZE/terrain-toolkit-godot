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
    var layers := config.get("height_layers", [])
    var mat := ShaderMaterial.new()
    mat.shader = load("res://src/utils/height_paint.gdshader")
    if layers is Array and layers.size() > 0:
        layers.sort_custom(func(a, b):
            return float(a.get("max", 0.0)) < float(b.get("max", 0.0))
        )
        var defaults := [
            {"max": 50.0, "color": Color(0.8, 0.7, 0.5)},
            {"max": 100.0, "color": Color(0.3, 0.6, 0.3)},
            {"max": 200.0, "color": Color(0.5, 0.5, 0.5)},
            {"max": 99999.0, "color": Color(0.9, 0.9, 0.9)}
        ]
        var merged := []
        for i in range(4):
            var src := i < layers.size() ? layers[i] : defaults[i]
            merged.append(src)
        mat.set_shader_parameter("t1", float(merged[0].get("max", 50.0)))
        mat.set_shader_parameter("t2", float(merged[1].get("max", 100.0)))
        mat.set_shader_parameter("t3", float(merged[2].get("max", 200.0)))
        var c1 := merged[0].get("color", Color(0.8, 0.7, 0.5))
        var c2 := merged[1].get("color", Color(0.3, 0.6, 0.3))
        var c3 := merged[2].get("color", Color(0.5, 0.5, 0.5))
        var c4 := merged[3].get("color", Color(0.9, 0.9, 0.9))
        mat.set_shader_parameter("c1", Vector3(c1.r, c1.g, c1.b))
        mat.set_shader_parameter("c2", Vector3(c2.r, c2.g, c2.b))
        mat.set_shader_parameter("c3", Vector3(c3.r, c3.g, c3.b))
        mat.set_shader_parameter("c4", Vector3(c4.r, c4.g, c4.b))
        var tex_keys := ["tex1", "tex2", "tex3", "tex4"]
        var use_keys := ["use_tex1", "use_tex2", "use_tex3", "use_tex4"]
        var tile_keys := ["tile1", "tile2", "tile3", "tile4"]
        for i in range(4):
            var layer := merged[i]
            var tile := float(layer.get("tile", 1.0))
            mat.set_shader_parameter(tile_keys[i], tile)
            var tex_val := layer.get("texture", null)
            if tex_val != null:
                var tex: Texture2D
                if typeof(tex_val) == TYPE_STRING:
                    tex = load(tex_val)
                elif tex_val is Texture2D:
                    tex = tex_val
                if tex != null:
                    mat.set_shader_parameter(tex_keys[i], tex)
                    mat.set_shader_parameter(use_keys[i], true)
    var mi := node as MeshInstance3D
    if mi != null:
        mi.material_override = mat
