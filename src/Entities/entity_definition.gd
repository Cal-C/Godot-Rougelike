class_name EntityDefinition
extends Resource


@export var name: String = "Unnamed Entity"
@export var textures: Array[Texture] = []  # Array to hold multiple textures

@export_category("Mechanics")
@export var is_blocking_movement: bool = true

@export_category("Defintions and types")
@export var fighter_definition: FighterComponentDefinition
@export var ai_type: Entity.AIType
