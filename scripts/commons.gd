extends Node2D

const room = "commons"

func _ready():
    update()
    SignalBus.student_moved.connect(_on_student_moved)

func _on_student_moved(_student, _location):
    update()

func update():
    # if Students.sean.location == room:
    #     $Sean.visible = true

    # $Andy.visible = false
    # $Sean.visible = false
    $John.visible = false
    $John2.visible = false

    if Students.john.location == room:
        if randf() <= 0.1:
            $John2.visible = true
        else:
            $John.visible = true

    # if Students.andy.location == room:
    #     if $John.visible or $Sean.visible:
    #         $Andy.visible = true
    #     else:
    #         $Andy2.visible = true
