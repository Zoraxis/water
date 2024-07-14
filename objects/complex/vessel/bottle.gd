extends RigidBody2D

@export var capacity = 1.0
@export var size = Vector2(0.5, 0.5)
@export var liquid_color: Color = Color.ORANGE_RED.lerp(Color.SADDLE_BROWN, 0.5)
@export var opacity = 0.7

var filled = 0

var dragged = false;
var braking = false;
var placable = false
var pickUpOffset = Vector2(0, 0)
var pickUpPos = Vector2(0, 0)

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
	if dragged:
		position = get_global_mouse_position() + pickUpOffset
		
	if Input.is_action_pressed("action_alt") and dragged:
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
	
func _on_draggable_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_released():
		dragged = false;
		G.dragged = false
		if not placable:
			position = pickUpPos
			placable = true
	if event is InputEventMouseButton and event.is_pressed() and not G.dragged:
		dragged = true
		G.dragged = true
		pickUpPos = position
		pickUpOffset = position - get_global_mouse_position()
