extends Node2D

const room = "small_gym"

func _ready():
    update()
    SignalBus.student_moved.connect(_on_student_moved)

func _on_student_moved(_student, _location):
    update()

func update():
    $Andy.visible = false
    $Sean.visible = false
    $John.visible = false

    if Students.sean.location == room:
        $Sean.visible = true
    if Students.john.location == room:
        $John.visible = true
    if Students.andy.location == room:
        $Andy.visible = true
