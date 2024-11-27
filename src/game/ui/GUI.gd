extends Control

var current_player: Player
@onready var player_texture: TextureRect = %Player
@onready var frame_texture: TextureRect = %Frame

@onready var life: Label = %Life

@onready var heart_1: TextureRect = %Heart1
@onready var heart_2: TextureRect = %Heart2
@onready var heart_3: TextureRect = %Heart3
@onready var heart_4: TextureRect = %Heart4
@onready var heart_5: TextureRect = %Heart5
@onready var heart_6: TextureRect = %Heart6
@onready var heart_7: TextureRect = %Heart7
@onready var heart_8: TextureRect = %Heart8

@onready var score: Label = %Score
@onready var label_score: Label = %LabelScore

@onready var continue_container: Control = $ContinueContainer
@onready var audio_stream_player: AudioStreamPlayer = $ContinueContainer/AudioStreamPlayer
@onready var timer: Timer = $ContinueContainer/Timer

var heart_green_texture = preload("res://assets/textures/ui/heart_green.png")
var heart_red_texture = preload("res://assets/textures/ui/heart_red.png")

var atlas_heart = AtlasTexture.new()

func set_current_player(player: Player) -> void:
	current_player = player
	setting_lifes()
	setting_hearts()

func _physics_process(_delta: float) -> void:
	if not is_instance_valid(current_player):  
		return
	
	setting_lifes()

func setting_hearts() -> void:
	for x in current_player.health.health_max:
		show_heart(x+1)
 
func setting_lifes() -> void:
	life.text = "x " + str(current_player.health.current_life)

func show_heart(number: int) -> void:
	self.get("heart_"+ str(number)).show()

func hide_heart(number: int) -> void:
	if self.get("heart_"+ str(number)):
		self.get("heart_"+ str(number)).hide()


func _on_score_updated_score(amount: Variant) -> void:
	var new_score = str(amount)
	match new_score.length():
		1:
			score.text = "0000" + new_score
		2:
			score.text = "000" + new_score
		3:
			score.text = "00" + new_score
		4:
			score.text = "0" + new_score
		5:
			score.text = new_score


func show_continue() -> void:
	continue_container.show()
	audio_stream_player.play()
	timer.start(3)

func hide_continue() -> void:
	continue_container.hide()

func start_upgrade() -> void:
	player_texture.modulate = '24ff00'
	frame_texture.modulate = '24ff00'
	life.add_theme_color_override("font_color", Color("#24ff00"))
	score.add_theme_color_override("font_color", Color("#24ff00"))
	label_score.add_theme_color_override("font_color", Color("#24ff00"))
	for x in current_player.health.health_max:
		atlas_heart.atlas = heart_green_texture
		atlas_heart.region = Rect2(254.0, 254.0, 484.0, 387.0)
		_change_heart_texture(x+1, atlas_heart)

func end_upgrade() -> void:
	player_texture.modulate = 'ffffff'
	frame_texture.modulate = 'ffffff'
	life.add_theme_color_override("font_color", Color("#e4d61b"))
	score.add_theme_color_override("font_color", Color("#e4d61b"))
	label_score.add_theme_color_override("font_color", Color("#e4d61b"))
	
	for x in current_player.health.health_max:
		atlas_heart.atlas = heart_red_texture
		atlas_heart.region = Rect2(254.0, 254.0, 484.0, 387.0)
		_change_heart_texture(x+1, atlas_heart)

func _change_heart_texture(number: int, atlas: AtlasTexture) -> void:
	self.get("heart_"+ str(number)).texture = atlas

func _on_timer_timeout() -> void:
	hide_continue()
