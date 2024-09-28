class_name FighterComponent
extends Component

signal hp_changed(hp, max_hp)


#statblock
var max_hp: int
var hp: int:
	set(value):
		hp = clampi(value, 0, max_hp)
		hp_changed.emit(hp, max_hp)
		if hp <= 0:
			die()
var defense: int
var power: int

# Preload the AtlasTextures into an array
var death_frames : Array[Texture]
var death_sprite = SpriteFrames.new()

func _init(definition: FighterComponentDefinition) -> void:
	max_hp = definition.max_hp
	hp = definition.max_hp
	defense = definition.defense
	power = definition.power
	# Create a new SpriteFrames resource
	

	# Create a new animation called "idle"
	death_sprite.add_animation("dead")

	# Add each texture from the entity definition as a frame in the "idle" animation
	for texture in definition.death_frames:
		if texture:
			death_sprite.add_frame("dead", texture)
		else:
			push_error("Texture is null in entity definition")

	

func die() -> void:
	var death_message: String
	
	if get_map_data().player == entity:
		death_message = "You died!"
		SignalBus.player_died.emit()
	else:
		death_message = "%s is dead!" % entity.get_entity_name()
	
	print(death_message)
	
	# Pass the AtlasTexture array directly to set_textures
	#entity.set_textures(death_frames)
	entity.frames = death_sprite
	entity.play("dead")

	# Modify the entity properties
	if entity.ai_component:
		entity.ai_component.queue_free()
		entity.ai_component = null
	entity.entity_name = "Remains of %s" % entity.entity_name
	entity.blocks_movement = false
	
	# Unregister the entity from the map data
	get_map_data().unregister_blocking_entity(entity)
	entity.type = Entity.EntityType.CORPSE
