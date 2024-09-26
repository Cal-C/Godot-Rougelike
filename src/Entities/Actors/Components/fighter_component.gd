class_name FighterComponent
extends Component

#statblock
var max_hp: int
var hp: int:
    set(value):
        hp = clampi(value, 0, max_hp)
var defense: int
var power: int

# Preload the AtlasTextures into an array
var death_frames = [
    preload("res://assets/images/DawnLike/Objects/Decor0.png"),
    preload("res://assets/images/DawnLike/Objects/Decor1.png")
]

func _init(definition: FighterComponentDefinition) -> void:
    max_hp = definition.max_hp
    hp = definition.max_hp
    defense = definition.defense
    power = definition.power
    death_frames = definition.death_frames

func die() -> void:
    var death_message: String
    
    if get_map_data().player == entity:
        death_message = "You died!"
    else:
        death_message = "%s is dead!" % entity.get_entity_name()
    
    print(death_message)
    
    # Create an AnimatedSprite2D node for the death animation
    var animated_sprite = AnimatedSprite2D.new()
    
    # Create a SpriteFrames resource and add the preloaded textures as frames
    var sprite_frames = SpriteFrames.new()
    for frame in death_frames:
        sprite_frames.add_frame("default", frame)
    
    # Assign the SpriteFrames resource to the AnimatedSprite2D
    animated_sprite.frames = sprite_frames
    animated_sprite.play("default")  # Assuming "default" is the animation name

    # Add the AnimatedSprite2D to the entity
    entity.add_child(animated_sprite)
    
    # Modify the entity properties
    entity.ai_component.queue_free()
    entity.ai_component = null
    entity.entity_name = "Remains of %s" % entity.entity_name
    entity.blocks_movement = false
    
    # Unregister the entity from the map data
    get_map_data().unregister_blocking_entity(entity)