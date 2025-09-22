extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var mensaje_paquetes: Label = $MensajePaquetes

var direccion = Vector2(0,0)
var velocidad = 200
var paquetes_restantes: int = 0

func _ready() -> void:
	mensaje_paquetes.text = ""


func _process(_delta):
	direccion = Vector2(0,0)
	if Input.is_action_pressed("flecha_izquierda"):
		direccion.x = -1
	if Input.is_action_pressed("flecha_derecha"):
		direccion.x = 1
	if Input.is_action_pressed("flecha_arriba"):
		direccion.y = -1
	if Input.is_action_pressed("flecha_abajo"):
		direccion.y = 1
		
	velocity = direccion * velocidad
	move_and_slide()

	if direccion == Vector2(0,0):
		sprite.play("idle")
	else:
		sprite.play("run")
	
		
	if direccion.x < 0:
		sprite.flip_h = true
	if direccion.x > 0:
		sprite.flip_h = false


func actualizar_contador_paquetes() -> void:
	paquetes_restantes -= 1
	if paquetes_restantes != 0:
		mensaje_paquetes.text = "Vamos, solo me faltan " + str(paquetes_restantes) + " paquetes!"
	else:
		mensaje_paquetes.text = "¡Terminamos!"
	mensaje_paquetes.show()
	get_tree().create_timer(5).timeout.connect(mensaje_paquetes.hide)
