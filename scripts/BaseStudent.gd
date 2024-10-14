extends Node

class_name Student

var location : String
var last_location : String
var random_location : String
var possible_locations : Array # Array of Strings
var default_possible_locations : Array 

var movement_delay : float # Seconds
var movement_chance : float # 0 - 1

var move_on_cams : bool
var level : int
var student_name : String
var timer 

func init(root):
    possible_locations = default_possible_locations

    timer = Timer.new()
    timer.timeout.connect(_on_timer_timeout)
    timer.wait_time = movement_delay
    timer.autostart = true
    root.add_child(timer)

    SignalBus.jumpscare.connect(_on_jumpscare)

func update_level(lev):
    level = lev
    movement_delay = 15 - (level * 0.5) + randf_range(0, 3)
    movement_chance = level * 0.05

func reset_student():
    location = "big_gym"
    possible_locations = default_possible_locations
    SignalBus.student_moved.emit(student_name, location)

func _on_jumpscare(student):
    self.queue_free()

func _on_timer_timeout():
    if (Global.cams and move_on_cams) or (not Global.cams):
        var bonus_chance = int(location == "door_left" or location == "door_right") * 0.2
        if randf() > movement_chance + bonus_chance:
            return

        if location == "door_left":
            if Global.left_door:
                Global.office_left_student = false
                reset_student()
                return
            else:
                SignalBus.jumpscare.emit(student_name)
                return

        elif location == "door_right":
            if Global.right_door:
                Global.office_right_student = false
                reset_student()
                return
            else:
                SignalBus.jumpscare.emit(student_name)
                return


        if possible_locations.size() == 0: return

        random_location = possible_locations[randi() % possible_locations.size()]
        while random_location == location:
            random_location = possible_locations[randi() % possible_locations.size()]

        if random_location == "office_left":
            if Global.office_left_student:
                return
            Global.office_left_student = true

        elif random_location == "office_right":
            if Global.office_right_student:
                return
            Global.office_right_student = true

        last_location = location
        location = random_location
        possible_locations = Global.LOCATIONS[location]

        SignalBus.student_moved.emit(student_name, location)
        print("%s moved from %s to %s" % [student_name, last_location, location])
