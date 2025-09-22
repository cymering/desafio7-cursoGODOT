extends Area2D
class_name Paquete

const MAX_ANCHO: float = 300.
const MAX_ALTO: float = 150.
@onready var sprite_2d: Sprite2D = $Sprite2D
signal paquete_agarrado

func _ready() -> void:
	body_shape_entered.connect(paquete_tocado)


func cambiar_imagen(nueva_imagen: String) -> void:
	sprite_2d.texture = load(nueva_imagen)
	sprite_2d.scale = Vector2(
		MAX_ANCHO / sprite_2d.texture.get_width() as float,
		MAX_ALTO / sprite_2d.texture.get_height() as float
		)

func paquete_tocado(_body_rid: RID, _body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	paquete_agarrado.emit()
	queue_free()
