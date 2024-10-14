extends Node

# 0 - 20
var andy_level = 3
var sean_level = 5
var john_level = 4
# var andy_level = 20
# var sean_level = 20
# var john_level = 20

var andy
var sean
var john

# Init Students
func _ready():
    setup_students()

func setup_students():
    andy = BaseStudent.duplicate()
    if andy_level > 0:
        andy.student_name = "Andy"
        andy.location = "big_gym"
        andy.default_possible_locations = ["small_gym", "old_cafe"]
        andy.move_on_cams = false
        andy.update_level(andy_level)

    sean = BaseStudent.duplicate()
    if sean_level > 0:
        sean.student_name = "Sean"
        sean.location = "big_gym"
        sean.default_possible_locations = ["north_hall"]
        sean.move_on_cams = true
        sean.update_level(sean_level)

    john = BaseStudent.duplicate()
    if john_level > 0:
        john.student_name = "John"
        john.location = "big_gym"
        john.default_possible_locations = ["commons"]
        john.move_on_cams = true
        john.update_level(john_level)
