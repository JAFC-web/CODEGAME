extends CharacterBody2D

var velocidad = 100
var brinco = -50
var gravedad = 100

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
