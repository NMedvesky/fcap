extends Node2D

var office_scene = preload("res://scenes/office.tscn")

func wait(seconds):
    await get_tree().create_timer(seconds).timeout

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
    get_tree().change_scene_to_packed(office_scene)

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
