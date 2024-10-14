extends Node2D

var debounce = false
var cameras_scene = preload("res://scenes/camera_overlay.tscn")

var cams

func _ready():
    cams = cameras_scene.instantiate()
    cams.visible = false
    add_child(cams)
    move_child(cams, 1)

    SignalBus.power_change.connect(_on_power_change)
    SignalBus.power_outage.connect(_on_power_outage)

func _physics_process(delta):
    if Global.power <= 0: return

    Global.power -= Global.power_usage * Global.POWER_DRAIN[Global.class_num] * delta
    if Global.power <= 0:
        Global.power = 0
        SignalBus.power_outage.emit()

    %Power.text = "%s%%" % int(Global.power)

func _on_clock_timer_timeout():
    """ Ran every second """
    Global.time += 1
    if Global.time % 60 == 0:
        %Time.text = "%s AM" % str(Global.time / 60)
        
        if Global.time / 60 == 6:
            SignalBus.class_over.emit()

func _on_power_outage():
    Global.power_usage -= 1
    SignalBus.power_change.emit()
    if Global.cams:
        debounce = false
        _on_flip_camera_mouse_entered()


func _on_flip_camera_mouse_entered():
    if debounce:
        return

    debounce = true

    if Global.cams:
        Global.cams = false
        cams.visible = false
        Global.power_usage -= 1
        SignalBus.power_change.emit()

        %CameraFlip.play_backwards()
        await get_tree().create_timer(0.5).timeout
    else:
        if Global.power <= 0: return

        Global.cams = true
        %CameraFlip.play()
        await get_tree().create_timer(0.5).timeout
        cams.visible = true

        Global.power_usage += 1
        SignalBus.power_change.emit()

    debounce = false

func _on_power_change():
    if Global.power_usage == 0:
        %PS1.visible = false
        %PS2.visible = false
        %PS3.visible = false
        %PS4.visible = false
        %PS5.visible = false
    elif Global.power_usage == 1:
        %PS1.visible = true
        %PS2.visible = false
        %PS3.visible = false
        %PS4.visible = false
        %PS5.visible = false
    elif Global.power_usage == 2:
        %PS1.visible = true
        %PS2.visible = true
        %PS3.visible = false
        %PS4.visible = false
        %PS5.visible = false
    elif Global.power_usage == 3:
        %PS1.visible = true
        %PS2.visible = true
        %PS3.visible = true
        %PS4.visible = false
        %PS5.visible = false
    elif Global.power_usage == 4:
        %PS1.visible = true
        %PS2.visible = true
        %PS3.visible = true
        %PS4.visible = true
        %PS5.visible = false
    elif Global.power_usage >= 5:
        %PS1.visible = true
        %PS2.visible = true
        %PS3.visible = true
        %PS4.visible = true
        %PS5.visible = true
