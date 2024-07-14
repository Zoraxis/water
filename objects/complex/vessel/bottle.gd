extends RigidBody2D

@export var capacity = 100.0
@export var size = Vector2(0.5, 0.5)
@export var liquid_color: Color = Color.ORANGE_RED.lerp(Color.SADDLE_BROWN, 0.5)
@export var opacity = 0.7

var filled = 1

var dragged = 0;
var braking = 0;
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
	if dragged > 0:
		position = get_global_mouse_position() + pickUpOffset
		dragged -= braking
	else:
		braking = 0
		
	if Input.is_action_pressed("action_alt") and dragged:
		if $vesselHolder.rotation < PI * 0.5:
			$vesselHolder.rotation += delta * 2
			$vesselHolder/mask/foolness.rotation += delta * 2
		if $vesselHolder.rotation > 1.4:
			pour_liquid($flow)
			filled -= delta
			$vesselHolder/mask/foolness.position.y += delta * 3
			
	else:
		if $vesselHolder.rotation > 0:
			$vesselHolder.rotation -= delta * 3
			$vesselHolder/mask/foolness.rotation -= delta * 2
			if $vesselHolder.rotation < 0:
				$vesselHolder.rotation = 0
			stop_pouring($flow)
	
func _on_draggable_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_released():
		dragged = 0;
		if not placable:
			get_parent().position = pickUpPos
			placable = true
	if event is InputEventMouseButton and event.is_pressed():
		dragged = 1;
		pickUpPos = get_parent().position
		pickUpOffset = get_parent().position - get_global_mouse_position()
		
	if event is InputEventMouseButton and event.is_released():
		braking = 1;
	if event is InputEventMouseButton and event.is_pressed():
		dragged = 10;
		pickUpOffset = position - get_global_mouse_position()
