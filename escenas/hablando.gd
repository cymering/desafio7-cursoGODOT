extends Node2D

@export var sprite: AnimatedSprite2D

func _process(delta):
	sprite.play("talk")
	
