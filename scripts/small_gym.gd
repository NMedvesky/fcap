extends Node2D

const room = "small_gym"

func _physics_process(_delta):
    $Andy.visible = false
    $Sean.visible = false
    $John.visible = false

    if Students.sean.location == room:
        $Sean.visible = true
    if Students.john.location == room:
        $John.visible = true
    if Students.andy.location == room:
        $Andy.visible = true
