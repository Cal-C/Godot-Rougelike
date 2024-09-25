extends Node2D

@export var entity_definition: EntityDefinition

func _ready():
	# Create a new AnimatedSprite2D node
	var animated_sprite = AnimatedSprite2D.new()
	
	# Create a new SpriteFrames resource
	var sprite_frames = SpriteFrames.new()

	sprite_frames.add_animation("default")
	
	# Add each texture from the entity definition as a frame in the "default" animation
	for texture in entity_definition.textures:
		sprite_frames.add_frame("default", texture)
	
	# Assign the sprite frames to the animated sprite
	animated_sprite.frames = sprite_frames
	
	animated_sprite.play("default")
	
	# Add the animated sprite to the current node
	add_child(animated_sprite)
