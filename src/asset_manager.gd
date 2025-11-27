extends Node

class_name AssetManager

static func export_terrain(node: Node3D, out_dir: String) -> bool:
    var mi := node as MeshInstance3D
    if mi == null:
        return false
    var mesh := mi.mesh
    if mesh == null:
        return false
    DirAccess.make_dir_recursive(out_dir)
    var mesh_path := out_dir.rstrip("/") + "/terrain_mesh.res"
    var meta_path := out_dir.rstrip("/") + "/metadata.json"
    var err := ResourceSaver.save(mesh, mesh_path)
    if err != OK:
        return false
    var meta := {
        "type": "terrain",
        "mesh": mesh_path,
        "transform": mi.transform
    }
    var f := FileAccess.open(meta_path, FileAccess.WRITE)
    if f == null:
        return false
    f.store_string(JSON.stringify(meta))
    f.flush()
    f.close()
    return true

static func import_terrain(in_dir: String) -> Node3D:
    var mesh_path := in_dir.rstrip("/") + "/terrain_mesh.res"
    var mesh_res := ResourceLoader.load(mesh_path)
    var mesh := mesh_res as ArrayMesh
    var inst := MeshInstance3D.new()
    inst.mesh = mesh
    var meta_path := in_dir.rstrip("/") + "/metadata.json"
    if FileAccess.file_exists(meta_path):
        var f := FileAccess.open(meta_path, FileAccess.READ)
        if f != null:
            var txt := f.get_as_text()
            var parsed := JSON.parse_string(txt)
            if typeof(parsed) == TYPE_DICTIONARY:
                var t := parsed.get("transform", null)
                if t != null:
                    inst.transform = t
            f.close()
    return inst
