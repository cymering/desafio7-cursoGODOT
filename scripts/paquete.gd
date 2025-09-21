extends Area2D
class_name Paquete

const MAX_ANCHO: float = 300.
const MAX_ALTO: float = 150.
@onready var sprite_2d: Sprite2D = $Sprite2D

func cambiar_imagen(nueva_imagen: String) -> void:
	sprite_2d.texture = load(nueva_imagen)
	sprite_2d.scale = Vector2(
		MAX_ANCHO / sprite_2d.texture.get_width() as float,
		MAX_ALTO / sprite_2d.texture.get_height() as float
		)
