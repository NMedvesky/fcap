extends Node2D

const room = "north_hall"

func _physics_process(_delta):
    $Andy.visible = false
    $Sean.visible = false
    $Sean2.visible = false
    $John.visible = false

    if Students.sean.location == room:
        if randf() <= 0.4:
            $Sean2.visible = true
        else:
            $Sean.visible = true
    if Students.john.location == room:
        $John.visible = true
    if Students.andy.location == room:
        $Andy.visible = true
