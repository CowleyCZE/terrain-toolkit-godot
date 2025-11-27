# Spec: Asset export

## User Story
Jako vývojář chci exportovat a importovat terénní assety včetně textur a kolizí.

## Acceptance Criteria
- Export vytvoří balíček s mesh, texturami a metadaty
- Import načte balíček a zrekonstruuje uzly ve scéně
- API pracuje bez závislosti na editoru

## Implementation Details
- Třída `AssetManager` poskytne funkce `export_terrain` a `import_terrain`
- Formát balíčku: adresářová struktura s JSON metadaty
- Podpora kolizí přes `CollisionShape3D`

