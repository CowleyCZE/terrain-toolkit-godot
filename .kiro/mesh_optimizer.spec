# Spec: Mesh optimalizace (LOD)

## User Story
Jako vývojář chci optimalizovat mesh terénu do LOD úrovní pro lepší výkon.

## Acceptance Criteria
- API přijme `ArrayMesh` a vrátí optimalizovaný mesh
- Konfigurace obsahuje počet LOD úrovní a cílové redukce
- Bez chyb při vstupu neobsahujícím LOD podporu

## Implementation Details
- Připrav utilitu `MeshUtils` s funkcí pro LOD
- Pokud není k dispozici nativní decimace, vrať původní mesh
- Rozhraní: `optimize_mesh_lod(mesh, lod_levels, target_reduction)`

