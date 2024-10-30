extends Control

var current_player: Player

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
