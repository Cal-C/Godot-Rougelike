class_name Entity
extends AnimatedSprite2D

enum AIType {NONE, HOSTILE}

var fighter_component: FighterComponent
var ai_component: BaseAIComponent

var _definition: EntityDefinition
var entity_name: String
var blocks_movement: bool
var map_data: MapData

func set_entity_type(entity_definition: EntityDefinition) -> void:
	# Sets base variables and adds components based on the entity definition
	_definition = entity_definition
	
	# Create a new SpriteFrames resource
	var new_sprite_frames = SpriteFrames.new()

	# Create a new animation called "idle"
	new_sprite_frames.add_animation("idle")

	# Add each texture from the entity definition as a frame in the "idle" animation
	for texture in entity_definition.textures:
		if texture:
			new_sprite_frames.add_frame("idle", texture)
		else:
			push_error("Texture is null in entity definition")

	# Assign the new sprite frames to the animated sprite
	self.frames = new_sprite_frames
	
	# Play the "idle" animation
	self.play("idle")
	
	blocks_movement = _definition.is_blocking_movement
	entity_name = _definition.name
	
	match entity_definition.ai_type:
		AIType.HOSTILE:
			ai_component = HostileEnemyAIComponent.new()
			add_child(ai_component)
	
	if entity_definition.fighter_definition:
		set_z_index(1) #objects 0 tiles -1 entities 1
		fighter_component = FighterComponent.new(entity_definition.fighter_definition)
		add_child(fighter_component)

var grid_position: Vector2i:
	set(value):
		grid_position = value
		position = Grid.grid_to_world(grid_position)

func _init(map_data: MapData, start_position: Vector2i, entity_definition: EntityDefinition) -> void:
	centered = false
	grid_position = start_position
	self.map_data = map_data
	set_entity_type(entity_definition)

func move(move_offset: Vector2i) -> void:
	if is_blocking_movement():
		map_data.unregister_blocking_entity(self)
		grid_position += move_offset
		map_data.register_blocking_entity(self)
	else:
		grid_position += move_offset

func is_blocking_movement() -> bool:
	return blocks_movement


func get_entity_name() -> String:
	return entity_name

func is_alive() -> bool: #the living dead are "alive" too.
	return ai_component != null
