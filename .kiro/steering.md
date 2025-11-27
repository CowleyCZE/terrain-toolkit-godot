# Směrnice pro AI chování

## Coding Standards
- Používej GDScript s typovými anotacemi pro parametry i návratové typy
- Dodržuj konvenci `class_name` pro veřejné API tříd
- Preferuj malé, čisté funkce s jasnými vstupy a výstupy
- Nepoužívej globální stav, konfigurace předávej přes slovníky

## Architecture Principles
- Odděluj generování, optimalizaci a správu assetů do samostatných modulů
- Funkcionální přístup, minimalizuj mutaci stavu
- Konfigurovatelnost pomocí slovníků pro flexibilitu a rozšiřitelnost
- API soustřeď do `TerrainGenerator` jako hlavní vstupní bod

## Performance Requirements
- Podporuj terén minimálně do rozlišení 512×512
- LOD optimalizace musí redukovat počet polygonů na úrovních o 50 %
- Dávkové zpracování musí pracovat bez UI blokování
- Minimalizuj alokace v horkých smyčkách a používej `Packed*Array`

