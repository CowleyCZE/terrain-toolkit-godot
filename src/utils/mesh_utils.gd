extends Node

class_name MeshUtils

static func image_to_mesh(image: Image, height_scale: float, scale: float) -> ArrayMesh:
    var w := image.get_width()
    var h := image.get_height()
    var vertices: PackedVector3Array = PackedVector3Array()
    var normals: PackedVector3Array = PackedVector3Array()
    var uvs: PackedVector2Array = PackedVector2Array()
    var indices: PackedInt32Array = PackedInt32Array()
    image.lock()
    for y in range(h):
        for x in range(w):
            var v := image.get_pixel(x, y).r * height_scale
            vertices.append(Vector3(x * scale, v, y * scale))
            normals.append(Vector3.UP)
            uvs.append(Vector2(float(x) / float(w), float(y) / float(h)))
    image.unlock()
    for y in range(h - 1):
        for x in range(w - 1):
            var i := y * w + x
            var i_right := i + 1
            var i_down := i + w
            var i_down_right := i + w + 1
            indices.append(i)
            indices.append(i_down)
            indices.append(i_right)
            indices.append(i_right)
            indices.append(i_down)
            indices.append(i_down_right)
    var arrays := []
    arrays.resize(Mesh.ARRAY_MAX)
    arrays[Mesh.ARRAY_VERTEX] = vertices
    arrays[Mesh.ARRAY_NORMAL] = normals
    arrays[Mesh.ARRAY_TEX_UV] = uvs
    arrays[Mesh.ARRAY_INDEX] = indices
    var mesh := ArrayMesh.new()
    mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
    return mesh

static func optimize_mesh_lod(mesh: ArrayMesh, lod_levels: int, target_reduction) -> ArrayMesh:
    return mesh

