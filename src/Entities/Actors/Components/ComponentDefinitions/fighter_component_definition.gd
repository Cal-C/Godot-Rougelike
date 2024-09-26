class_name FighterComponentDefinition
extends Resource

@export_category("Stats")
@export var max_hp: int
@export var power: int
@export var defense: int

@export_category("Visuals")
# Export an array of textures for the death animation frames
@export var death_frames: Array[Texture] = []