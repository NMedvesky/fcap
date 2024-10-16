extends Node

const POWER_DRAIN = [
    0.125,
    0.14,
    0.15,
    0.16,
    0.16,
]

const STUDENT_LEVELS = [
    {
        "andy": 0,
        "sean": 3,
        "john": 2,
    },
    {
        "andy": 0,
        "sean": 4,
        "john": 4,
    },
    {
        "andy": 2,
        "sean": 5,
        "john": 6,
    },
    {
        "andy": 6,
        "sean": 8,
        "john": 8,
    },
    {
        "andy": 15,
        "sean": 15,
        "john": 15,
    },
]

const LOCATIONS = {
    "big_gym"     : ["north_hall", "small_gym", "old_cafe", "commons"],
    "small_gym"   : ["office_left", "old_cafe"],
    "old_cafe"    : ["small_gym", "office_right"],
    "commons"     : ["east_hall"],
    "north_hall"  : ["science_lab"],
    "east_hall"   : ["old_cafe"],
    "main_hall"   : ["office_left"],
    "science_lab" : ["main_hall"],
    "office_left" : ["door_left"],
    "office_right": ["door_right"],
    "door_left"   : [],
    "door_right"  : [],
}

const OFFICE_POS = {
    "left_window" : Vector2(434, 329),
    "left_door"   : Vector2(251, 335),
    "right_window": Vector2(956, 337),
    "right_door"  : Vector2(1146, 335)
}

## SESSION INFO
var class_num = 1
var custom_game = false

## NIGHT INFO
var power : float = 100.0
var power_usage : int = 1
var time : int = 0 # seconds
var cams : bool = false
var alive : bool = true

var left_door : bool = false
var right_door : bool = false

# Array[String, Vector2]
var office_left_student
var office_right_student


# const LOCATIONS = {
#     "big_gym": ["north_hall", "small_gym", "old_cafe", "commons"],
#     "small_gym": ["big_gym", "office_left", "old_cafe"],
#     "old_cafe": ["big_gym", "small_gym", "east_hall", "office_right"],
#     "commons": ["big_gym", "east_hall"],
#     "north_hall": ["big_gym", "science_lab"],
#     "east_hall": ["commons", "old_cafe"],
#     "main_hall": ["science_lab", "office_left"],
#     "science_lab": ["north_hall", "main_hall"],
#     "office_left": ["big_gym"],
#     "office_right": ["big_gym"],
# }
