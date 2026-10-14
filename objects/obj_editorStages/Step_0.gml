if keyboard_check_pressed(vk_enter)
{
	stage_clear(obj_editorStages_bf, obj_editorStages_dad, obj_editorStages_gf)
	stage_create(script_text, obj_editorStages_bf, obj_editorStages_dad, obj_editorStages_gf)
}
global.mGP_gameX += (keyboard_check(vk_right) - keyboard_check(vk_left)) * 12*global.fpsMult
global.mGP_gameY += (keyboard_check(vk_down) - keyboard_check(vk_up)) * 12*global.fpsMult
camera_set_view_size(view_camera[0], global.gameSizeW,global.gameSizeH)
camera_set_view_pos(view_camera[0], global.mGP_gameX-global.gameSizeW/2, global.mGP_gameY-global.gameSizeH/2)
camera_set_view_angle(view_camera[0], 0)