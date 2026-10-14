if instance_exists(obj_mainSettings_keys) exit

debugui_checkbox(300, 50, "settings_hitSounds", true, "Gameplay - Hitsounds", 2, 2,true)
debugui_checkbox(300, 100, "settings_ghostTapping", true, "Gameplay - Ghost Tapping", 2, 2, true)
debugui_checkbox(300, 150, "settings_botPlay", true, "Gameplay - Botplay", 2, 2, true)
debugui_checkbox(300, 250, "settings_noteSplashes", true, "Visuals - Note Splashes", 2, 2, true)
debugui_checkbox(300, 350, "settings_vSync", true, "Graphics - VSync", 2, 2, true)

var _sss = point_in_rectangle(mouse_x, mouse_y, 0, 400-16, global.gameSizeW, 400+16)
gpu_set_texfilter(false)
draw_set_alpha(1)
draw_set_halign(0)
draw_set_valign(1)
draw_set_colour(_sss ? c_aqua : c_white)
draw_set_font(fnt_score)
draw_text(300, 400, "Graphic - Max FPs : " + string(global.settings_maxFps))
if mouse_check_button_pressed(mb_left) && _sss
	global.settings_maxFps = get_integer("Enter new 'Max FPs'", global.settings_maxFps)
	
_sss = point_in_rectangle(mouse_x, mouse_y, 0, 500-16, global.gameSizeW, 500+16)
draw_set_colour(_sss ? c_aqua : c_white)
draw_text(300, 500, "Change Controls")
if mouse_check_button_pressed(mb_left) && _sss
	instance_create_depth(0,0,0,obj_mainSettings_keys)

_sss = point_in_rectangle(mouse_x, mouse_y, 0, 600-16, global.gameSizeW, 600+16)
draw_set_colour(_sss ? c_aqua : c_white)
draw_text(300, 600, "Save & Apply Options")
if mouse_check_button_pressed(mb_left) && _sss
{
	mS_load(false)
	mS_save()
}

draw_set_colour(c_white)
draw_text(25, global.gameSizeH-25, "('Escape' to go back to title screen)")
gpu_set_texfilter(true)

if keyboard_check_pressed(vk_escape)
	room_goto(rm_titleScreen)