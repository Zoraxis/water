extends RigidBody2D

@export var capacity = 1.0
@export var size = Vector2(0.5, 0.5)
@export var liquid_color: Color = Color.ORANGE_RED.lerp(Color.SADDLE_BROWN, 0.5)
@export var opacity = 0.7

var filled = 0

func pour_liquid(flow):
	flow.visible = true
	
func stop_pouring(flow):
	flow.visible = false

func _ready():
	$draggableCollider.reparent($vesselHolder/draggable)
	$outlineCollider.reparent($vesselHolder/outlineTrigger);
	$vesselHolder/outlineTrigger.reparent($sprite);
	
	$sprite.reparent($vesselHolder);
	$mask.reparent($vesselHolder)
	$vesselHolder.scale = size
	$collider.scale = size
	liquid_color.a = opacity
	$flow.set_color(liquid_color)

func _physics_process(delta):
	if Input.is_action_pressed("action_alt") and $vesselHolder/draggable.dragged:
		if $vesselHolder.rotation < PI * 0.5:
			$vesselHolder.rotation += delta * 2
			$vesselHolder/mask/ziza.rotation += delta * 2
		if $vesselHolder.rotation > 1.4 and filled < 1:
			pour_liquid($flow)
			filled += delta * .2
			$vesselHolder/mask/ziza.update_pos(filled)
			
	else:
		if $vesselHolder.rotation > 0:
			$vesselHolder.rotation -= delta * 3
			$vesselHolder/mask/ziza.rotation -= delta * 2
			if $vesselHolder.rotation < 0:
				$vesselHolder.rotation = 0
			stop_pouring($flow)
