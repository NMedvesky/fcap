extends Node2D

func wait(seconds):
    await get_tree().create_timer(seconds).timeout

func _ready():
    update_custom_menu()

func _on_andy_timer_timeout():
    if randf() <= 0.6:
        %AndyAnim.frame = (randi() % 2) + 1
        await wait(randf_range(0.1, 0.2))
        $AndyTimer.wait_time = randf_range(0.1, 2)
        %AndyAnim.frame = 0

### Menu
func _on_new_game_pressed():
    %new_game.disabled = true
    %continue_game.disabled = true
    %custom_game.disabled = true
    %settings.disabled = true

    var tween = self.create_tween()
    tween.tween_property($ColorRect, "modulate:a", 1.0, 2)
    tween.tween_interval(1)
    await tween.finished

    $Class.text = $Class.text.left(-1) + str(Global.class_num)
    $Class.visible = true
    await wait(2)
    
    var root = get_tree().get_root()
    Students.andy.init(root)
    Students.sean.init(root)
    Students.john.init(root)
    SceneSwitcher.switch_scene("res://scenes/office.tscn")



### Hover selection arrows >>
func add_selection_arrows(button):
    if button.disabled: return
    button.text = ">> " + button.text.right(-3)

func remove_selection_arrows(button):
    if button.disabled: return
    button.text = "   " + button.text.right(-3)

func _on_new_game_mouse_entered():
    add_selection_arrows(%new_game)

func _on_new_game_mouse_exited():
    remove_selection_arrows(%new_game)

func _on_continue_game_mouse_entered():
    add_selection_arrows(%continue_game)

func _on_continue_game_mouse_exited():
    remove_selection_arrows(%continue_game)

func _on_custom_game_mouse_entered():
    add_selection_arrows(%custom_game)

func _on_custom_game_mouse_exited():
    remove_selection_arrows(%custom_game)

func _on_settings_mouse_entered():
    add_selection_arrows(%settings)

func _on_settings_mouse_exited():
    remove_selection_arrows(%settings)





var andy_level = 20
var sean_level = 20
var john_level = 20

func update_custom_menu():
    %AndyLevel.text = str(andy_level)
    %SeanLevel.text = str(sean_level)
    %JohnLevel.text = str(john_level)

func _on_increase_andy_pressed():
    andy_level += 1
    andy_level = clamp(andy_level, 0, 20)
    update_custom_menu()

func _on_decrease_andy_pressed():
    andy_level -= 1
    andy_level = clamp(andy_level, 0, 20)
    update_custom_menu()

func _on_increase_sean_pressed():
    sean_level += 1
    sean_level = clamp(sean_level, 0, 20)
    update_custom_menu()

func _on_decrease_sean_pressed():
    sean_level -= 1
    sean_level = clamp(sean_level, 0, 20)
    update_custom_menu()

func _on_increase_john_pressed():
    john_level += 1
    john_level = clamp(john_level, 0, 20)
    update_custom_menu()

func _on_decrease_john_pressed():
    john_level -= 1
    john_level = clamp(john_level, 0, 20)
    update_custom_menu()


func _on_custom_game_pressed():
    %AndyAnim.visible = false
    %Title.visible = false
    %v_buttons.visible = false

    %CustomGameMenu.visible = true

func _on_back_button_custom_pressed():
    %AndyAnim.visible = true
    %Title.visible = true
    %v_buttons.visible = true

    %CustomGameMenu.visible = false


func _on_start_button_custom_pressed():
    Students.andy.update_level(andy_level)
    Students.sean.update_level(sean_level)
    Students.john.update_level(john_level)

    var root = get_tree().get_root()
    Students.andy.init(root)
    Students.sean.init(root)
    Students.john.init(root)
    SceneSwitcher.switch_scene("res://scenes/office.tscn")

