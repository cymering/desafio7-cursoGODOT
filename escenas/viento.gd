extends Node2D

var JUEGO = preload("res://escenas/juego.tscn")

func _ready() -> void:
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_packed(JUEGO)
