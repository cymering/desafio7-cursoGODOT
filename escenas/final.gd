extends Node2D


func _ready() -> void:
	$AnimationPlayer.play("cargar_paquetes")


func terminar():
	get_tree().quit()
