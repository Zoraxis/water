extends Node2D

@export var max_hp = 6

func _ready():
	G.current_hp = max_hp
	$Timer.start()
	$Timer2.start()
	update_health_bar()
	
func _on_timer_timeout():
	if G.current_hp > 0:
		G.current_hp -= 1
		$particle.position.x -= 40
	else:
		$particle.queue_free()
		G.gameOver()

func _on_timer_2_timeout():
	update_health_bar()
	
func update_health_bar():
	match G.current_hp:
		6:
			$HP1.visible = true
			$HP1/HP2.visible = true
			$HP1/HP2/HP3.visible = true
			$HP1/HP2/HP3/HP4.visible = true
			$HP1/HP2/HP3/HP4/HP5.visible = true
			$HP1/HP2/HP3/HP4/HP5/HP6.visible = true
		5:
			$HP1.visible = true
			$HP1/HP2.visible = true
			$HP1/HP2/HP3.visible = true
			$HP1/HP2/HP3/HP4.visible = true
			$HP1/HP2/HP3/HP4/HP5.visible = true
			$HP1/HP2/HP3/HP4/HP5/HP6.visible = false
		4:
			$HP1.visible = true
			$HP1/HP2.visible = true
			$HP1/HP2/HP3.visible = true
			$HP1/HP2/HP3/HP4.visible = true
			$HP1/HP2/HP3/HP4/HP5.visible = false
			$HP1/HP2/HP3/HP4/HP5/HP6.visible = false
		3:
			$HP1.visible = true
			$HP1/HP2.visible = true
			$HP1/HP2/HP3.visible = true
			$HP1/HP2/HP3/HP4.visible = false
			$HP1/HP2/HP3/HP4/HP5.visible = false
			$HP1/HP2/HP3/HP4/HP5/HP6.visible = false
		2:
			$HP1.visible = true
			$HP1/HP2.visible = true
			$HP1/HP2/HP3.visible = false
			$HP1/HP2/HP3/HP4.visible = false
			$HP1/HP2/HP3/HP4/HP5.visible = false
			$HP1/HP2/HP3/HP4/HP5/HP6.visible = false
		1:
			$HP1.visible = true
			$HP1/HP2.visible = false
			$HP1/HP2/HP3.visible = false
			$HP1/HP2/HP3/HP4.visible = false
			$HP1/HP2/HP3/HP4/HP5.visible = false
			$HP1/HP2/HP3/HP4/HP5/HP6.visible = false
		0:
			$HP1.visible = false
			$HP1/HP2.visible = false
			$HP1/HP2/HP3.visible = false
			$HP1/HP2/HP3/HP4.visible = false
			$HP1/HP2/HP3/HP4/HP5.visible = false
			$HP1/HP2/HP3/HP4/HP5/HP6.visible = false
			$Timer.stop()
			get_tree().change_scene_to_file("res://gameover/gameover.tscn")
