extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
#@export var sprite: AnimatedSprite2D

var direccion = Vector2(0,0)
var velocidad = 200

func _process(delta):
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
