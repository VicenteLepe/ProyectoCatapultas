extends Node2D

enum PlayerType {
	A, 
	B
}

@export var player: PlayerType
@onready var base = $Base

func _ready():
	match player:
		PlayerType.A:
			Game.player_A = base
			base.player = "A"
		PlayerType.B:
			Game.player_B = base
			base.player = "B"


