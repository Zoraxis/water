extends RigidBody2D

@export var capacity = 1.0
@export var size = Vector2(0.5, 0.5)
@export var typeNum = 0

var filled = 0
var flowEntered = null
var isOnNapkin = false

func _ready():
	$draggableCollider.reparent($vesselHolder/draggable)
	$outlineCollider.reparent($vesselHolder/outlineTrigger)
	$inCollider.reparent($vesselHolder/in)
	$vesselHolder/outlineTrigger.reparent($sprite)
	
	$sprite.reparent($vesselHolder)
	$mask.reparent($vesselHolder)
	$flow.reparent($vesselHolder)
	$vesselHolder.scale = size
	$collider.scale = size

func _process(delta):
	if Input.is_action_pressed("middleMouse"):
		G.current_hp = 6
	if flowEntered != null:
		if flowEntered.visible == true and filled < 1.0:
			filled += delta * .5
			$vesselHolder/mask/ziza.update_pos(filled)
			$vesselHolder/mask.modulate = $vesselHolder/mask.modulate.lerp(flowEntered.color, delta)
		else:
			$vesselHolder/mask/ziza.update_pos(filled)
	else:
		$vesselHolder/mask/ziza.update_pos(filled)
		
	if filled <= 0:
		$vesselHolder/flow.visible = false

func _on_in_body_entered(body):
	if body.is_in_group("FLOW") and body != $vesselHolder/flow:
		if $vesselHolder/mask.modulate == Color.WHITE:
			$vesselHolder/mask.modulate = body.color
		flowEntered = body

func _on_in_body_exited(body):
	if body.is_in_group("FLOW"):
		flowEntered = null
		$vesselHolder/mask/ziza.update_pos(filled)

func drag_stop():
	if isOnNapkin:
		G.orders.resolveOrder($vesselHolder/mask.modulate, self)

func _physics_process(delta):
	if Input.is_action_pressed("action_alt") and $vesselHolder/draggable.dragged:
		if $vesselHolder/mask/ziza.rotation > PI * -0.11:
			$vesselHolder/mask/ziza.rotation -= delta
		if get_parent().rotation < PI * 0.5:
			get_parent().rotation += delta * 3
		if get_parent().rotation > PI * 0.45 and filled > 0:
			$vesselHolder/flow.set_color($vesselHolder/mask.modulate)
			$vesselHolder/flow.visible = true
			filled -= delta
			$vesselHolder/mask/ziza.update_pos(filled)
	else:
		$vesselHolder/flow.visible = false
		if $vesselHolder/mask/ziza.rotation < 0:
			$vesselHolder/mask/ziza.rotation += delta * 1.5
		if get_parent().rotation > 0:
			get_parent().rotation -= delta * 4
		
	move_and_collide(Vector2(0,0))
