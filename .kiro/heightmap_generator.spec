# Spec: Heightmap generátor

## User Story
Jako vývojář chci generovat heightmapu pomocí Perlin noise, abych mohl tvořit procedurální terén.

## Acceptance Criteria
- Při zadání seed a rozměrů vznikne obraz s hodnotami 0–1
- Frekvence a počet oktáv jsou konfigurovatelné
- Výstup je normalizovaný do rozsahu 0–1
- API vrátí `Image` vhodný pro další zpracování

## Implementation Details
- Použij `FastNoiseLite` pro generování Perlin/Simplex
- Vytvoř utilitu `HeightmapUtils` pro tvorbu a normalizaci
- Parametry: `width`, `depth`, `seed`, `frequency`, `octaves`
- Výsledný `Image` ve formátu `FORMAT_RF` s jedním kanálem

