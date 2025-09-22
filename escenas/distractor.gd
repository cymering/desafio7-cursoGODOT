extends Node2D
class_name Distractor

const MAX_ANCHO: float = 300.
const MAX_ALTO: float = 150.

signal paquete_borrado

@onready var sprite_2d: Sprite2D = $Sprite2D
const PAQUETE = preload("res://escenas/paquete.tscn")

func cambiar_imagen(nueva_imagen: String) -> void:
	sprite_2d.texture = load(nueva_imagen)
	sprite_2d.scale = Vector2(
		MAX_ANCHO / sprite_2d.texture.get_width() as float,
		MAX_ALTO / sprite_2d.texture.get_height() as float
		)
	sprite_2d.z_index = 1


func agregar_paquete(imagen: String) -> void:
	var paquete_nuevo: Paquete = PAQUETE.instantiate()
	add_child(paquete_nuevo)
	paquete_nuevo.cambiar_imagen(imagen)
	paquete_nuevo.paquete_agarrado.connect(paquete_borrado.emit)
