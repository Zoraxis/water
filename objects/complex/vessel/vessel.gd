extends RigidBody2D

@export var capacity = 100.0
@export var size = Vector2(0.5, 0.5)

var filled = 0

var dragged = 0;
var braking = 0;
var placable = false
var pickUpOffset = Vector2(0, 0)
var pickUpPos = Vector2(0, 0)

func _ready():
	$draggableCollider.reparent($vesselHolder/draggable)
	$outlineCollider.reparent($vesselHolder/outlineTrigger);
	$inCollider.reparent($vesselHolder/in)
	$vesselHolder/outlineTrigger.reparent($sprite);
	
	$sprite.reparent($vesselHolder);
	$mask.reparent($vesselHolder);
	$vesselHolder.scale = size
	$collider.scale = size

func _process(delta):
	if $vesselHolder/mask/ziza:
		if $vesselHolder/mask/ziza.state == true:
			filled = 0.5
		

func _on_in_body_entered(body):
	$vesselHolder/mask.modulate = body.get_color()
	$vesselHolder/mask/ziza.toggle(true)

func _on_in_body_exited(body):
	$vesselHolder/mask/ziza.toggle(false)

func _physics_process(delta):
	if dragged > 0:
		print(get_parent().name)
		get_parent().position = get_global_mouse_position() + pickUpOffset
		dragged -= braking
	else:
		braking = 0

	if Input.is_action_pressed("action_alt") and dragged:
		if $vesselHolder/mask/ziza.rotation > PI * -0.11:
			$vesselHolder/mask/ziza.rotation -= delta
		if get_parent().rotation < PI * 0.5:
			get_parent().rotation += delta * 3
	else:
		if $vesselHolder/mask/ziza.rotation < 0:
			$vesselHolder/mask/ziza.rotation += delta * 1.5
		if get_parent().rotation > 0:
			get_parent().rotation -= delta * 4
		
	move_and_collide(Vector2(0,0))

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
