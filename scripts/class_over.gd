extends Node2D

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
        if Global.class_num < 5 and not Global.custom_game:
            Global.class_num += 1
        else:
            Global.class_num == 5 and not Global.custom_game:
            $WinLabel.text = "YOU WIN"
            $StaticSFX.play()
            await get_tree().create_timer(12).timeout

            Global.alive = true
            SceneSwitcher.switch_scene("res://scenes/main_menu.tscn")
            return

        $DeathLabel.visible = false
        $WinLabel.visible = true

        $BellSFX.play()

        $WinLabel.text = "5 AM"
        await get_tree().create_timer(2).timeout
        $WinLabel.text = "6 AM"
        await get_tree().create_timer(9).timeout
    else:
        $StaticSFX.play()

        $DeathLabel.visible = true
        $WinLabel.visible = false
        await get_tree().create_timer(5).timeout
    
    Global.alive = true

    SceneSwitcher.switch_scene("res://scenes/main_menu.tscn")
