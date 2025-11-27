extends Node

class_name MeshOptimizer

static func optimize_lod(mesh: ArrayMesh, options: Dictionary) -> ArrayMesh:
    var lod_levels: int = int(options.get("lod_levels", 0))
    var target_reduction := options.get("target_reduction", [])
    return MeshUtils.optimize_mesh_lod(mesh, lod_levels, target_reduction)
