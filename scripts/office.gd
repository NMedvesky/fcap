extends Node2D

const SPEED = 0.005
var scroll_speed = 0
var shader_scroll

const DOOR_TIME = 0.3

var left_door_moving : bool = false
var right_door_moving : bool = false

func _ready():
    shader_scroll = %ScrollView.material.get_shader_parameter("scroll")
    SignalBus.student_moved.connect(_on_student_move)
    SignalBus.power_outage.connect(_on_power_outage)

func _on_student_move(student_name, location):
    var student = %Office.get_node(student_name)
    if location == "office_left":
        student.position = Global.OFFICE_POS["left_window"]
        student.visible = true
    elif location == "door_left":
        student.position = Global.OFFICE_POS["left_door"]
        student.visible = true
    if location == "office_right":
        student.position = Global.OFFICE_POS["right_window"]
        student.visible = true
    elif location == "door_right":
        student.position = Global.OFFICE_POS["right_door"]
        student.visible = true
    else:
        student.visible = false

func _on_power_outage():
    %LeftDoorButton.disabled = true
    %RightDoorButton.disabled = true
    left_door(false)
    right_door(false)

func _on_left_area_mouse_entered():
    scroll_speed = -SPEED 

func _on_left_area_mouse_exited():
    scroll_speed = 0

func _on_right_area_mouse_entered():
    scroll_speed = SPEED 

func _on_right_area_mouse_exited():
    scroll_speed = 0

func left_door(close):
    Global.power_usage += int(close)*2 - 1
    Global.left_door = close
    var y_pos = 317 if close else -20
    var tween = get_tree().create_tween()
    tween.tween_property(%LeftDoor, "position", Vector2(253, y_pos), DOOR_TIME)
    SignalBus.power_change.emit()

func right_door(close):
    Global.power_usage += int(close)*2 - 1
    Global.right_door = close
    var y_pos = 317 if close else -20
    var tween = get_tree().create_tween()
    tween.tween_property(%RightDoor, "position", Vector2(1150, y_pos), DOOR_TIME)
    SignalBus.power_change.emit()

func _on_left_door_button_toggled(toggled_on):
    left_door(toggled_on)

func _on_right_door_button_toggled(toggled_on):
    right_door(toggled_on)

func _physics_process(delta: float) -> void:
    if Global.cams:
        %LeftDoorButton.disabled = true
        %RightDoorButton.disabled = true
        return
    elif Global.power > 0:
        %LeftDoorButton.disabled = false
        %RightDoorButton.disabled = false

    # Scroll
    shader_scroll += scroll_speed
    shader_scroll = clamp(shader_scroll, -0.085, 0.1)
    %ScrollView.material.set_shader_parameter("scroll", shader_scroll)

    # Move GUI
    %GUIControl.position.x -= scroll_speed * 1500
    %GUIControl.position.x = clamp(%GUIControl.position.x, -150, 130)
