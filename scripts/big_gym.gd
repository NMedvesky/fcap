extends Node2D

const room = "big_gym"

func _physics_process(_delta):
    $Andy.visible = false
    $Sean.visible = false
    $John.visible = false
    $Andy2.visible = false

    if Students.sean.location == room:
        $Sean.visible = true
    if Students.john.location == room:
        $John.visible = true
    if Students.andy.location == room:
        if $John.visible or $Sean.visible:
            $Andy.visible = true
        else:
            $Andy2.visible = true
