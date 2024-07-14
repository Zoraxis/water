extends RigidBody2D

@export var capacity = 100.0
@export var size = Vector2(0.5, 0.5)

var filled = 0

var dragged = false;
var placable = false
var pickUpOffset = Vector2(0, 0)
var pickUpPos = Vector2(0, 0)

var flowEntered = null

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
	if $vesselHolder/mask/ziza:
		if $vesselHolder/mask/ziza.state == true:
			filled = 0.5
		
	if flowEntered != null:
		if flowEntered.visible == true:
			filled += delta
			$vesselHolder/mask/ziza.toggle(true)
			$vesselHolder/mask.modulate = $vesselHolder/mask.modulate.lerp(flowEntered.color, delta)
		else:
			$vesselHolder/mask/ziza.toggle(false)
	else:
		$vesselHolder/mask/ziza.toggle(false)

func _on_in_body_entered(body):
	if body.is_in_group("FLOW") and body != $vesselHolder/flow:
		if $vesselHolder/mask.modulate == Color.WHITE:
			$vesselHolder/mask.modulate = body.color
		flowEntered = body

func _on_in_body_exited(body):
	if body.is_in_group("FLOW"):
		flowEntered = null
		$vesselHolder/mask/ziza.toggle(false)

func _physics_process(delta):
	if dragged:
		get_parent().position = get_global_mouse_position() + pickUpOffset

	if Input.is_action_pressed("action_alt") and dragged:
		if $vesselHolder/mask/ziza.rotation > PI * -0.11:
			$vesselHolder/mask/ziza.rotation -= delta
		if get_parent().rotation < PI * 0.5:
			get_parent().rotation += delta * 3
		if get_parent().rotation > PI * 0.45 and filled > 0:
			$vesselHolder/flow.set_color($vesselHolder/mask.modulate)
			$vesselHolder/flow.visible = true
			filled -= delta
	else:
		$vesselHolder/flow.visible = false
		if $vesselHolder/mask/ziza.rotation < 0:
			$vesselHolder/mask/ziza.rotation += delta * 1.5
		if get_parent().rotation > 0:
			get_parent().rotation -= delta * 4
		
	move_and_collide(Vector2(0,0))

func _on_draggable_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_released():
		dragged = false
		G.dragged = false
		if not placable:
			get_parent().position = pickUpPos
			placable = true
	if event is InputEventMouseButton and event.is_pressed() and not G.dragged:
		dragged = true
		G.dragged = true
		pickUpPos = get_parent().position
		pickUpOffset = get_parent().position - get_global_mouse_position()
