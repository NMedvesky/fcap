extends Node2D

const WAIT_TIME = 3

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

    if Global.alive:
        $DeathLabel.visible = false
        $WinLabel.visible = true
        $WinLabel.text = "5 AM"
        await get_tree().create_timer(WAIT_TIME*0.66).timeout
        $WinLabel.text = "6 AM"
    else:
        $DeathLabel.visible = true
        $WinLabel.visible = false
    
    Global.alive = true

    await get_tree().create_timer(WAIT_TIME).timeout
    SceneSwitcher.switch_scene("res://scenes/main_menu.tscn")
