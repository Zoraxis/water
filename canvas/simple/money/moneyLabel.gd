extends Label

func _ready():
	G.coinLabel = self

func alterText():
	text = str(G.money)
	$explosion/particles.restart()
	$explosion/particles.emitting = true
