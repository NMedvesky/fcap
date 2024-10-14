extends Node

var current_scene = null

func _ready():
    var root = get_tree().root
    current_scene = root.get_child(root.get_child_count() - 1)

func switch_scene(path):
    _deferred_switch_scene.call_deferred(path)

func _deferred_switch_scene(path):
    current_scene.free()

    var s = ResourceLoader.load(path)
    current_scene = s.instantiate()
    get_tree().root.add_child(current_scene)
