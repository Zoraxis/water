extends RigidBody2D

@export var capacity = 100.0
@export var size = Vector2(0.5, 0.5)

var filled = 0

var dragged = 0;
var braking = 0;
var placable = false
var pickUpOffset = Vector2(0, 0)
var pickUpPos = Vector2(0, 0)
var liquid_color: Color = Color.SADDLE_BROWN

func pour_liquid(flow):
	flow.set_color(liquid_color)
	flow.start_pouring()
	emit_signal("pour_started", liquid_color) 
	
func stop_pouring(flow):
	flow.stop_pouring()
	emit_signal("pour_stopped")

func _ready():
	$draggableCollider.reparent($vesselHolder/draggable)
	$outlineCollider.reparent($vesselHolder/outlineTrigger);
	$vesselHolder/outlineTrigger.reparent($sprite);
	
	$sprite.reparent($vesselHolder);
	$vesselHolder.scale = size
	$collider.scale = size

func _physics_process(delta):
	if dragged > 0:
		position = get_global_mouse_position() + pickUpOffset
		dragged -= braking
	else:
		braking = 0
		
	if Input.is_action_pressed("action_alt") and dragged:
		if $vesselHolder.rotation < PI * 0.5:
			$vesselHolder.rotation += delta * 2
		if $vesselHolder.rotation > 1.4:
			pour_liquid($flow)
			
	else:
		if $vesselHolder.rotation > 0:
			$vesselHolder.rotation -= delta * 3
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
