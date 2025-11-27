# Terrain Data Toolkit for Godot 4

> **AI-powered terrain generation and management toolkit** for Godot Engine 4.x, powered by **Kiro's intelligent workflows** for seamless development.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Godot Version](https://img.shields.io/badge/Godot-4.1%2B-blue)](https://godotengine.org)
[![Built with Kiro](https://img.shields.io/badge/Built%20with-Kiro%20AI-purple)](https://kiro.dev)

## 🎯 Features

- **Automated Heightmap Generation** - Create procedural terrain from elevation data, noise functions, or image files
- **Mesh Optimization** - Automatically generate Level-of-Detail (LOD) meshes for performance optimization
- **Asset Pipeline Automation** - Seamless import/export workflows with texture baking and collision setup
- **Batch Processing** - Process multiple terrains simultaneously with intelligent batching
- **Kiro AI Integration** - Powered by AI hooks for automated validation, optimization, and documentation
- **Zero Configuration** - Works out-of-the-box with sensible defaults
- **Extensible Architecture** - Easy to customize and extend for specialized terrain needs

## 📦 Installation

### Requirements

- **Godot Engine** 4.1 or later
- **GDScript** (built-in)
- Optional: **HTerrain Plugin** for advanced terrain features
- Optional: **Kiro IDE** (for using AI workflows)

### Quick Setup (3 Steps)

1. **Clone the repository**
   ```bash
   git clone https://github.com/CowleyCZE/terrain-toolkit-godot.git
   cd terrain-toolkit-godot
   ```

2. **Copy to your Godot project**
   ```bash
   cp -r src/* YOUR_PROJECT/scripts/terrain/
   cp -r .kiro/* YOUR_PROJECT/.kiro/  # If using Kiro IDE
   ```

3. **Enable in Godot**
   - Open your Godot project
   - Go to `Project Settings` > `Autoload`
   - Add `src/terrain_generator.gd` as `TerrainGenerator`

### Alternative: Add as Git Submodule

```bash
cd YOUR_PROJECT
git submodule add https://github.com/CowleyCZE/terrain-toolkit-godot.git addons/terrain-toolkit
```

## 🚀 Quick Start

### Basic Terrain Generation

```gdscript
# Create a simple terrain from noise
extends Node3D

func _ready():
    var terrain = TerrainGenerator.create_terrain({
        "width": 256,
        "depth": 256,
        "scale": 1.0,
        "height_scale": 50.0,
        "noise_type": "perlin",
        "noise_seed": 12345
    })
    add_child(terrain)
```

### Loading from Heightmap Image

```gdscript
func _ready():
    var heightmap_image = Image.load_from_file("res://assets/heightmap.png")
    var terrain = TerrainGenerator.create_from_heightmap(heightmap_image, {
        "height_scale": 50.0,
        "scale": (1.0, 1.0, 1.0)
    })
    add_child(terrain)
```

### Mesh Optimization (LOD)

```gdscript
func _ready():
    var terrain = TerrainGenerator.create_terrain({...})
    
    # Optimize mesh with multiple LOD levels
    var optimized = TerrainGenerator.optimize_mesh(terrain.mesh, {
        "lod_levels": 3,
        "target_reduction": [0.5, 0.25, 0.1]
    })
    
    terrain.mesh = optimized
    add_child(terrain)
```

### Texture Painting

```gdscript
func _ready():
    var terrain = TerrainGenerator.create_terrain({...})
    
    # Apply terrain layers based on height
    TerrainGenerator.paint_by_height(terrain, {
        "height_layers": [
            {"min": 0, "max": 50, "material": load("res://materials/sand.tres")},
            {"min": 50, "max": 100, "material": load("res://materials/grass.tres")},
            {"min": 100, "max": 200, "material": load("res://materials/rock.tres")},
            {"min": 200, "max": 300, "material": load("res://materials/snow.tres")}
        ]
    })
    
    add_child(terrain)
```

## 🤖 Kiro Integration Guide

### Why Kiro for Terrain Development?

Kiro's AI-powered workflows dramatically accelerate terrain toolkit development:

- **Intelligent Code Generation** - Ask for terrain features in plain language; Kiro generates optimized GDScript
- **Automated Testing** - AI hooks automatically create test scenarios for heightmap validation
- **Documentation Auto-generation** - Keep docs in sync with code automatically
- **Performance Optimization** - AI suggests mesh optimization strategies based on your terrain complexity

### Setting Up Kiro Workflows

#### 1. Install Kiro IDE

Visit [kiro.dev](https://kiro.dev) and install Kiro IDE on your development machine.

#### 2. Open Project in Kiro

```bash
kiro open /path/to/terrain-toolkit-godot
```

#### 3. Create a Spec for Terrain Features

Kiro uses **Specs** - executable requirements that guide AI implementation:

```markdown
# Spec: Heightmap from Perlin Noise

## User Story
As a game developer, I want to generate a heightmap using Perlin noise so that I can create procedural terrain.

## Acceptance Criteria
GIVEN a noise seed and terrain dimensions
WHEN creating a heightmap
THEN generate a 2D array of height values between 0 and 1

## Implementation Details
- Use Godot's FastNoiseLite for Perlin noise generation
- Support configurable frequency, amplitude, and octaves
- Normalize output to [0, 1] range
```

#### 4. Configure Steering Rules

Create `.kiro/steering.md` to guide AI behavior:

```markdown
# Terrain Toolkit Steering Rules

## Coding Standards
- Follow GDScript best practices from Godot documentation
- Use type hints for all function parameters and returns
- Write clear docstrings for public functions

## Architecture Principles
- Functional approach: favor pure functions over state mutation
- Separation of concerns: keep generation, optimization, and rendering separate
- Configuration-driven: use dictionaries for flexible parameters

## Performance Requirements
- Support terrain up to 512x512 without frame drops
- LOD system must reduce polygon count by 50% per level
- Batch processing should handle 5+ terrains efficiently
```

#### 5. Use Agent Hooks

Kiro's **Agent Hooks** run AI agents in the background:

**Example: Auto-testing Hook**

```yaml
# .kiro/hooks.yaml
hooks:
  - name: test-heightmap-generation
    event: on_file_save
    pattern: src/*.gd
    action: |
      Run unit tests for heightmap generation
      Verify output dimensions match input parameters
      Check height values are within expected range [0, 1]
```

#### 6. Kiro MCP Integration

Connect Kiro to Godot documentation:

```bash
# In Kiro command palette (Ctrl+Shift+P):
Kiro: Configure MCP Server

# Add Godot API reference
Name: Godot 4 Docs
Type: HTTP
URL: https://docs.godotengine.org/en/stable/
```

## 📚 API Reference

### `TerrainGenerator` (Main Class)

#### `create_terrain(config: Dictionary) -> Node3D`

Create a procedural terrain mesh.

```gdscript
var terrain = TerrainGenerator.create_terrain({
    "width": 256,           # Terrain width in vertices
    "depth": 256,           # Terrain depth in vertices
    "scale": 1.0,           # XZ scale per vertex
    "height_scale": 50.0,   # Y scale for height
    "noise_type": "perlin", # "perlin", "simplex", "cellular"
    "noise_seed": 12345,    # Random seed
    "noise_frequency": 0.1, # Noise frequency
    "octaves": 4            # Number of octaves (for fractal noise)
})
```

#### `create_from_heightmap(image: Image, config: Dictionary) -> Node3D`

Create terrain from a heightmap image.

```gdscript
var image = Image.load_from_file("res://heightmap.png")
var terrain = TerrainGenerator.create_from_heightmap(image, {
    "height_scale": 50.0,
    "scale": Vector3(1.0, 1.0, 1.0)
})
```

#### `optimize_mesh(mesh: Mesh, config: Dictionary) -> Mesh`

Generate LOD versions of a mesh.

```gdscript
var optimized = TerrainGenerator.optimize_mesh(terrain_mesh, {
    "lod_levels": 3,
    "target_reduction": [0.5, 0.25, 0.1]  # 50%, 75%, 90% reduction
})
```

## 📂 Project Structure

```
terrain-toolkit-godot/
├── .kiro/                          # Kiro AI workflows & specs
│   ├── heightmap_generator.spec    # Heightmap generation spec
│   ├── mesh_optimizer.spec         # LOD optimization spec
│   ├── steering.md                 # AI behavior guidelines
│   └── README.md                   # Kiro integration docs
├── src/                            # GDScript source code
│   ├── terrain_generator.gd        # Main generator class
│   ├── mesh_optimizer.gd           # Mesh optimization
│   ├── asset_manager.gd            # Export/import manager
│   └── utils/
│       ├── heightmap_utils.gd      # Heightmap utilities
│       ├── noise_utils.gd          # Noise generation
│       └── mesh_utils.gd           # Mesh utilities
├── examples/                       # Example scenes
│   ├── basic_terrain_demo.tscn     # Basic usage demo
│   ├── lod_optimization_demo.tscn  # LOD demo
│   └── heightmap_painting_demo.tscn
├── docs/                           # Documentation
│   ├── INSTALLATION.md
│   ├── USAGE.md
│   └── API.md
├── LICENSE                         # MIT License
└── README.md
```

## 🛠️ Development with Kiro

### Typical Workflow

1. **Define Requirements** in Kiro Specs
   ```bash
   kiro spec create "Mesh LOD Generation"
   ```

2. **Let AI Generate Code**
   - Kiro reads your spec and codebase context
   - Claude AI generates implementation
   - Code appears with full type hints and documentation

3. **Automated Testing**
   - Agent hooks run tests on save
   - Catch issues before manual testing

4. **Continuous Documentation**
   - Update specs, docs auto-generate
   - No more outdated documentation

## 📖 Examples

See `examples/` directory for complete working scenes:

- **basic_terrain_demo.tscn** - Simple procedural terrain with camera controls
- **lod_optimization_demo.tscn** - LOD system with visual distance comparison
- **heightmap_painting_demo.tscn** - Texture painting by height ranges

## 🤝 Contributing

Contributions welcome! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/awesome-terrain`)
3. Follow the steering rules in `.kiro/steering.md`
4. Commit with clear messages
5. Push to branch and create Pull Request

## 📄 License

MIT License - See LICENSE file for details

## 🙏 Acknowledgments

- **Godot Engine** - Amazing open-source game engine
- **Kiro AI** - AI-powered development platform
- **HTerrain Plugin** - Reference for terrain implementation
- **Community** - Godot and open-source community support

## 📞 Support

- 📖 **Documentation**: See `docs/` folder
- 🐛 **Issues**: Report on GitHub Issues
- 💬 **Discussions**: Open GitHub Discussions
- 🌐 **Web**: [Kiro.dev](https://kiro.dev) | [Godot.org](https://godotengine.org)

---

**Built for the Kiroween Hackathon** 🎃👻

_Terrain Data Toolkit - Making game terrain development 10x faster with AI_
