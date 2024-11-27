@tool
extends Node2D

@export var zone:int
@export var enemy_scene: PackedScene
@export var amount: int
@export var wait_timer: float = 5.0
@export var extents: Vector2:
	set (value):
		extents = value
		## Aquí decimos "si estás en contexto del editor, manda un aviso de redibujado"
		if Engine.is_editor_hint():
			force_update_transform()
#@export var pathfinding_path: NodePathEne
#@onready var pathfinding: Node = get_node_or_null(pathfinding_path)

var random = RandomNumberGenerator.new()
@onready var timer: Timer = $Timer

func _ready() -> void:
	## "Engine.editor_hint" es una flag que le permite al script saber en qué
	## contexto se está ejecutando, si en runtime del juego o en el contexto
	## del editor.
	if Engine.is_editor_hint():
		force_update_transform()
	else:
		call_deferred("_initialize")


## Fijarse como esta función se ejecuta tranquilamente, ya que controlamos
## de nunca llamarla en contexto del editor, solo en runtime.
func _initialize() -> void:
	#for i in amount:
		timer.start(wait_timer)
		var enemy_instance: Enemy = enemy_scene.instantiate()
		enemy_instance.zone = zone
		var enemy_pos: Vector2 = Vector2(random.randf_range(global_position.x, global_position.x + extents.x), random.randf_range(global_position.y, global_position.y + extents.y))
		enemy_instance.initialize(self, enemy_pos)
		amount -= 1
		if amount == 0:
			timer.stop()
		#turret_instance.pathfinding = pathfinding


## Al definir el setter, se pueden asignar las variables en contexto de
## "tool" en el editor y utilizarlas.
#func _set_extents(value: Vector2) -> void:
	#extents = value
	#
	### Aquí decimos "si estás en contexto del editor, manda un aviso de redibujado"
	#if Engine.is_editor_hint():
		#force_update_transform()


## Función primitiva de dibujo
func _draw() -> void:
	if Engine.is_editor_hint():
		draw_rect(Rect2(Vector2.ZERO, extents), Color.BLUE, false)


func _on_timer_timeout() -> void:
	## "Engine.editor_hint" es una flag que le permite al script saber en qué
	## contexto se está ejecutando, si en runtime del juego o en el contexto
	## del editor.
	if Engine.is_editor_hint():
		force_update_transform()
	else:
		call_deferred("_initialize")
