if instance_exists(obj_mainSettings_keys) exit
if instance_exists(obj_mainSettings_hitsound) exit

var _sss
gpu_set_texfilter(0)
draw_set_alpha(1)
draw_set_halign(0)
draw_set_valign(1)
draw_set_font(fnt_score)

if menu == 1
{
	debugui_checkbox(300, 50, "settings_hitSounds", true, "Hitsounds", 2, 2,true)
	
	if global.settings_hitSounds
	{
		_sss = point_in_rectangle(mouse_x, mouse_y, 0, 100-16, global.gameSizeW, 100+16)
		draw_set_colour(_sss ? c_aqua : c_white)
		draw_text(300, 100, "Choose Hitsound Preset")
		if mouse_check_button_pressed(mb_left) && _sss
			instance_create_depth(0,0,0,obj_mainSettings_hitsound)
	}
	
	debugui_checkbox(300, 200, "settings_ghostTapping", true, "Ghost Tapping", 2, 2, true)
	debugui_checkbox(300, 250, "settings_botPlay", true, "Botplay", 2, 2, true)
}
if menu == 2
{
	debugui_checkbox(300, 50, "settings_noteSplashes", true, "Note Splashes", 2, 2, true)
}
if menu == 3
{
	debugui_checkbox(300, 50, "settings_vSync", true, "VSync", 2, 2, true)

	_sss = point_in_rectangle(mouse_x, mouse_y, 0, 100-16, global.gameSizeW, 100+16)
	draw_set_colour(_sss ? c_aqua : c_white)
	draw_text(300, 100, "Max FPs : " + string(global.settings_maxFps))
	if mouse_check_button_pressed(mb_left) && _sss
		global.settings_maxFps = get_integer("Enter new 'Max FPs'", global.settings_maxFps)
}
if menu == 0
{
	_sss = point_in_rectangle(mouse_x, mouse_y, 0, 50-16, global.gameSizeW, 50+16)
	draw_set_colour(_sss ? c_aqua : c_white)
	draw_text(300, 50, "Gameplay")
	if mouse_check_button_pressed(mb_left) && _sss
		menu = 1
		
	_sss = point_in_rectangle(mouse_x, mouse_y, 0, 100-16, global.gameSizeW, 100+16)
	draw_set_colour(_sss ? c_aqua : c_white)
	draw_text(300, 100, "Visuals")
	if mouse_check_button_pressed(mb_left) && _sss
		menu = 2
		
	_sss = point_in_rectangle(mouse_x, mouse_y, 0, 150-16, global.gameSizeW, 150+16)
	draw_set_colour(_sss ? c_aqua : c_white)
	draw_text(300, 150, "Graphics")
	if mouse_check_button_pressed(mb_left) && _sss
		menu = 3
	
	_sss = point_in_rectangle(mouse_x, mouse_y, 0, 200-16, global.gameSizeW, 200+16)
	draw_set_colour(_sss ? c_aqua : c_white)
	draw_text(300, 200, "Change Controls")
	if mouse_check_button_pressed(mb_left) && _sss
		instance_create_depth(0,0,0,obj_mainSettings_keys)

	_sss = point_in_rectangle(mouse_x, mouse_y, 0, 600-16, global.gameSizeW, 600+16)
	draw_set_colour(_sss ? c_aqua : c_white)
	draw_text(300, 600, "Exit & Save")
	if keyboard_check_pressed(vk_escape) || (mouse_check_button_pressed(mb_left) && _sss)
	{
		mS_load(false)
		mS_save()
		room_goto(rm_titleScreen)
	}
}
else
{
	_sss = point_in_rectangle(mouse_x, mouse_y, 0, 600-16, global.gameSizeW, 600+16)
	draw_set_colour(_sss ? c_aqua : c_white)
	draw_text(300, 600, "Go Back")
	if (mouse_check_button_pressed(mb_left) && _sss) || keyboard_check_pressed(vk_escape)
		menu = 0
}

draw_set_colour(c_white)
draw_text(25, global.gameSizeH-25, "('Escape' to go back to title screen)")
draw_set_valign(0)
gpu_set_texfilter(1)
