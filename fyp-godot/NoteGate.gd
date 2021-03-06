extends Spatial

export(int, 1,4) var line

onready var mesh = get_node("MeshInstance")
var gate_scale = Vector3(1, 1, SETTINGS._settings.player.aproach_speed * 0.1 )
var is_pressed = false
var is_hitting = false
var note_hit 

func _ready():
	set_process_input(true)
	$"NoteGateCont".set_scale(gate_scale)
	mesh.hide()
	
func _input(event):
	match line:
		1:
			if event.is_action_pressed("key1"):
				is_pressed = true
				is_hitting = true
			elif event.is_action_released("key1"):
				is_pressed = false
				is_hitting = false
				note_hit = null
		2:
			if event.is_action_pressed("key2"):
				is_pressed = true
				is_hitting = true
			elif event.is_action_released("key2"):
				is_pressed = false
				is_hitting = false
				note_hit = null
		3:
			if event.is_action_pressed("key3"):
				is_pressed = true
				is_hitting = true
			elif event.is_action_released("key3"):
				is_pressed = false
				is_hitting = false
				note_hit = null
		4:
			if event.is_action_pressed("key4"):
				is_pressed = true
				is_hitting = true
			elif event.is_action_released("key4"):
				is_pressed = false
				is_hitting = false
				note_hit = null
				
func _process(_delta):
	if is_pressed:
		mesh.show()
	else:
		mesh.hide()

func play_anim():
	$Animations/AnimationPlayer.play("short_hit")
