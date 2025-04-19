extends Node2D

const SheepScene = preload("res://Prefabs/sheep.tscn")
@onready var chime = $Chime

func _ready() -> void:
	var sheep = spawn_sheep($FirstSheepSpawn.global_position, Global.SheepState.SLEEPING)
	Global.deathPoint = $DeathPoint.global_position
	Global.spawnPoint = $SpawnPoint.global_position
	
func _process(delta: float) -> void:
	if Global.is_dreaming:
		# passive time progression
		Global.minutes_since_midnight += delta * Global.time_scale
	
func spawn_sheep(spawnPoint: Vector2, state: Global.SheepState):
	var sheep = SheepScene.instantiate()
	sheep.value = Global.VARIANTS.keys()[randi_range(0, Global.VARIANTS.size() - 1)]
	sheep.global_position = spawnPoint
	sheep.add_to_group("sheep")
	add_child(sheep)
	sheep.set_state(state)
	return sheep

func _on_death_wall_body_entered(body: Node2D) -> void:
	if body.is_in_group("sheep"): # sheep crashed into fence
		body.set_state(Global.SheepState.DEAD)

func _on_pass_wall_body_entered(body: Node2D) -> void:
	if body.is_in_group("sheep") and body.state == Global.SheepState.MOVING: # sheep jumped the fence
		match body.value:
			5: chime.pitch_scale = 1
			10: chime.pitch_scale = 1
			30: chime.pitch_scale = 1.2
			60: chime.pitch_scale = 1.3
		chime.play()
		var new_time = Global.minutes_since_midnight + body.value
		Global.minutes_since_midnight = new_time
		body.emit_hearts(true)
		spawn_sheep(Global.spawnPoint, Global.SheepState.MOVING)
