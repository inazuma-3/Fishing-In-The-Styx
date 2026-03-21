extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = Timer.new()
	timer.wait_time = 1
	timer.autostart = true
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	var fish = preload("res://Main/scenes/System/Fish/fish.tscn").instantiate()
	fish.position.y = 0.2
	fish.position.x = randf_range(-30, 30)
	fish.position.z = randf_range(-30, 30)
	add_child(fish)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
