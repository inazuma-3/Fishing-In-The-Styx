extends RigidBody3D

@onready var launched = false
@export var player: Node3D

var dir: Vector3
var throw_force: float = 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var direction = -global_transform.basis.z
	if not launched:
		apply_impulse(direction * throw_force)
		launched = true
