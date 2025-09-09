extends Area2D

const SPEED := 600.0
var direction: Vector2 = Vector2.ZERO

func _init(dir: Vector2 = Vector2.ZERO) -> void:
    direction = dir

func _ready() -> void:
    body_entered.connect(_on_body_entered)
    area_entered.connect(_on_area_entered)

func _physics_process(delta: float) -> void:
    position += direction * SPEED * delta
    if not get_viewport_rect().has_point(global_position):
        queue_free()

func _on_body_entered(_body: Node) -> void:
    queue_free()

func _on_area_entered(_area: Area2D) -> void:
    queue_free()