extends Node2D

@onready var fight_zone: FightZone = $FightZone
@onready var fight_zone_2: FightZone = $FightZone2
@onready var fight_zone_3: FightZone = $FightZone3
@onready var fight_zone_4: FightZone = $FightZone4

func enemy_dead(zone:int) -> void:
	print("Enemy dead for zone: ", zone)
	match zone:
		1:
			fight_zone.enemy_dead()
		2:
			fight_zone_2.enemy_dead()
		3:
			fight_zone_3.enemy_dead()
		4:
			fight_zone_4.enemy_dead()
