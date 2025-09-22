extends Node2D

const DISTRACTOR = preload("res://escenas/distractor.tscn")
const FINAL = preload("res://escenas/final.tscn")
var path_de_distractores: String = "res://assets/distractores/"
var path_de_paquetes: String = "res://assets/paquetes/"
var imagenes_distractores: Array[String]
var imagenes_paquetes: Array[String]

@onready var grupo_de_marcadores: Node2D = $GrupoDeMarcadores
@onready var grupo_de_distractores: Node2D = $GrupoDeDistractores
@onready var cartel_paquetes_restantes: Label = $CartelPaquetesRestantes

var paquetes_restantes: int = 0

func _ready() -> void:
	imagenes_distractores = listar_imagenes_en_array(path_de_distractores)
	imagenes_paquetes = listar_imagenes_en_array(path_de_paquetes)
	generar_distractores()
	generar_paquetes()
	get_tree().create_timer(10).timeout.connect(cartel_paquetes_restantes.queue_free)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("cerrar_juego"):
		get_tree().quit()


func generar_distractores() -> void:
	for marca: Marker2D in grupo_de_marcadores.get_children():
		var nuevo_distractor = DISTRACTOR.instantiate()
		grupo_de_distractores.add_child(nuevo_distractor)
		nuevo_distractor.position = marca.position
		nuevo_distractor.cambiar_imagen(path_de_distractores +
			imagenes_distractores[randi_range(0, imagenes_distractores.size()-1)]
		)


func generar_paquetes() -> void:
	for distractor: Distractor in grupo_de_distractores.get_children():
		#esto es como tirar una moneda, en lugar de cara o cruz, 0 o 1
		if randi_range(0, 1) == 1:
			distractor.agregar_paquete(path_de_paquetes +
			imagenes_paquetes[randi_range(0, imagenes_paquetes.size()-1)]
			)
			distractor.paquete_borrado.connect(actualizar_paquetes)
			paquetes_restantes += 1
	
	cartel_paquetes_restantes.text = "Se perdieron " + str(paquetes_restantes) + " paquetes!"
	$Nivel/Personaje.paquetes_restantes = paquetes_restantes


func actualizar_paquetes() -> void:
	paquetes_restantes -= 1
	$Nivel/Personaje.actualizar_contador_paquetes()
	if paquetes_restantes <= 0:
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_packed(FINAL)


#copiado de los docs, hace una lista de los archivos de una carpeta
func listar_imagenes_en_array(path: String) -> Array[String]:
	var nombres_imagenes: Array[String] = []
	var dir: DirAccess = DirAccess.open(path)
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".png") or file_name.ends_with(".jpg"):
				nombres_imagenes.append(file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	
	return nombres_imagenes
