extends Node2D

const WAIT_TIME = 2

var main_menu = preload("res://scenes/main_menu.tscn")

func _ready():
    Global.power = 100.0
    Global.power_usage = 1
    Global.time = 0 # seconds
    Global.cams = false

    Global.left_door = false
    Global.right_door = false

    Global.office_left_student = null
    Global.office_right_student = null

    Students.setup_students()
    
    await get_tree().create_timer(WAIT_TIME).timeout
    get_tree().change_scene_to_packed(main_menu)
