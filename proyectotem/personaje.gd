extends CharacterBody2D

var velocidad = 100
var brinco = -50
var gravedad = 100
var point = 0
func _ready():
	add_to_group("jugador")

func _physics_process(delta):
	var direccion = Input.get_axis("ui_left", "ui_right")
	velocity.x = direccion * velocidad
	
	# Aplicar gravedad
	if not is_on_floor():
		velocity.y += gravedad * delta
	
	# Salto
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = brinco
	
	# ANIMACIONES - separadas de la lógica de movimiento
	# Primero verificar si está en el aire
	if not is_on_floor():
		if velocity.y < 0:  # Subiendo
			$AnimationPlayer.play("salto")
		else:  # Cayendo (velocity.y >= 0)
			$AnimationPlayer.play("caida")
	# Si está en el suelo
	else:
		if direccion < 0:
			$AnimationPlayer.play("caminariz")
		elif direccion > 0:
			$AnimationPlayer.play("caminar")
		else:
			$AnimationPlayer.play("idle")
	
	move_and_slide()
func _on_reset_body_entered(body: Node2D) -> void:
	get_tree().reload_current_scene()



func _on_door_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://lv_2.tscn")
	
	pass # Replace with function body.

func Pickup_coin():
	point+= 1
	get_node("Camera2D/HUD").update_count(point)
