extends Path2D

onready var maskSprite = $PathFollow2D/Sprite
onready var maskPlayer = $PathFollow2D/AnimationPlayer
enum talkingState {happy, angry, sad, mando, iron}
var state = talkingState.happy
onready var poof = $PathFollow2D/Particles2D
onready var timer = $PathFollow2D/Particles2D/Timer
var hasPoof = talkingState.happy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
		$PathFollow2D.set_offset($PathFollow2D.get_offset()+15*delta)
		_skewMask()
		_talkingState()
		_playTalking()

func _playTalking() -> void:
	if Input.is_action_pressed("space"):
		match state:
			talkingState.happy:
				maskPlayer.play("talking")
			talkingState.angry:
				maskPlayer.play("angryTalking")
			talkingState.sad:
				maskPlayer.play("sadTalking")
	else:
		match state:
			talkingState.happy:
				hasPoof = talkingState.happy
				maskPlayer.play("happy")
			talkingState.angry:
				hasPoof = talkingState.angry
				maskPlayer.play("angry")
			talkingState.sad:
				hasPoof = talkingState.sad
				maskPlayer.play("sad")
			talkingState.mando:
				if hasPoof != talkingState.mando:
					poof.restart()
					hasPoof = talkingState.mando
					poof.visible = true
					timer.start()
					maskPlayer.play("mando")
			talkingState.iron:
				if hasPoof != talkingState.iron:
					poof.restart()
					hasPoof = talkingState.iron
					poof.visible = true
					timer.start()
					maskPlayer.play("iron")

func _talkingState() -> void:
	if Input.is_action_pressed("angry"):
		state = talkingState.angry
	elif Input.is_action_pressed("sad"):
		state = talkingState.sad
	elif Input.is_action_pressed("happy"):
		state = talkingState.happy
	elif Input.is_action_pressed("mando"):
		state = talkingState.mando
	elif Input.is_action_pressed("iron"):
		state = talkingState.iron
func _skewMask() -> void:
	if Input.is_action_pressed("ui_right"):
		maskSprite.get_material().set_shader_param("active", true)
		maskSprite.get_material().set_shader_param("left", false)
	elif Input.is_action_pressed("ui_left"):
		maskSprite.get_material().set_shader_param("active", true)
		maskSprite.get_material().set_shader_param("left", true)
	else:
		maskSprite.get_material().set_shader_param("active", false)
		maskSprite.get_material().set_shader_param("left", false)


func _setHasPoofFalse() -> void:
	hasPoof = false

func _setHasPoofTrue() -> void:
	hasPoof = true
