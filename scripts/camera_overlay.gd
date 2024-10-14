extends Node2D

var cameras = {
    "big_gym"    : preload("res://scenes/big_gym.tscn"),
    "commons"    : preload("res://scenes/commons.tscn"),
    "east_hall"  : preload("res://scenes/east_hall.tscn"),
    "small_gym"  : preload("res://scenes/small_gym.tscn"),
    "north_hall" : preload("res://scenes/north_hall.tscn"),
    "science_lab": preload("res://scenes/science_lab.tscn"),
    "main_hall"  : preload("res://scenes/main_hall.tscn"),
    "old_cafe"   : preload("res://scenes/old_cafe.tscn"),
}

var camera

func _ready():
    var group = $Control/BigGym.button_group
    group.pressed.connect(change_camera)
    camera = cameras["big_gym"].instantiate()
    add_child(camera)
    move_child(camera, 0)

func change_camera(button):
    remove_child(camera)
    var location_scene = cameras[button.get_meta("location")]
    camera = location_scene.instantiate()
    add_child(camera)
    move_child(camera, 0)
