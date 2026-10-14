timer += 1 * global.fpsMult
if timer >= 15
{
	global.mGP_gameX = lerp(global.mGP_gameX,x+240,0.025 * global.fpsMult)
	global.mGP_gameY = lerp(global.mGP_gameY,y+155,0.025 * global.fpsMult)
}
camera_set_view_size(view_camera[0], global.gameSizeW*(2-global.mGP_gameZoom),global.gameSizeH*(2-global.mGP_gameZoom))
camera_set_view_pos(view_camera[0], global.mGP_gameX-(camera_get_view_width(view_camera[0])/2), global.mGP_gameY-(camera_get_view_height(view_camera[0])/2))
camera_set_view_angle(view_camera[0], global.mGP_gameAngle)
if keyboard_check_pressed(vk_backspace)
{
	instance_destroy(obj_fadeout)
	with instance_create_depth(0,global.gameSizeH/2,0,obj_fadeout)
		roomTarget = global.sD_cancel_room
}
if keyboard_check_pressed(vk_enter) && !comfirmed
{
	intro = false
	comfirmed = true
	deadendmusic = audio_play_sound(deadendmusicid,10,false)
	if audio_exists(deadmusic) audio_stop_sound(deadmusic)
	sprw_play("deathEnd",true)
}
else if !(sprw_exists(id) && (sprw_frame_index < ds_list_size(sprw_cur_anim_frames) - 1)) && intro && !comfirmed
{
	intro = false
	deadmusic = audio_play_sound(deadmusicid,10,true)
	sprw_play("deathLoop",true)
	if audio_exists(deadsfx) audio_stop_sound(deadsfx)
}
if !comfirmed
	exit
image_alpha -= 0.006 * global.fpsMult
if image_alpha <= 0.1 && !instance_exists(obj_fadeout)
{
	with instance_create_depth(0,0,0,obj_fadeout)
		roomTarget = global.sD_comfirm_room
}