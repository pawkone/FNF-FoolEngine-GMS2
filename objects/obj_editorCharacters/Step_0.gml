if keyboard_check_pressed(vk_escape) && global.savedebugmenu_fromdebug
	room_goto(rm_debugmenu)
if instance_exists(obj_editorCharacters_delete)
	exit
if !sprw_exists(id)
	exit
	
	
	
	
if buttonslimit < array_length(things)
{
	if keyboard_check_pressed(vk_space)
	|| keyboard_check_pressed(ord("W"))
	|| keyboard_check_pressed(ord("S"))
	{
		if keyboard_check_pressed(ord("W"))
			selected -= 1
		else if keyboard_check_pressed(ord("S"))
			selected += 1
		selected = clamp(selected,8,array_length(things)-1)
		sprw_play(things[selected], true)
	}
}
	
var _hsp = (keyboard_check(ord("J")) * 10*global.fpsMult) + (keyboard_check(ord("L")) * -10*global.fpsMult)
var _vsp = (keyboard_check(ord("I")) * 10*global.fpsMult) + (keyboard_check(ord("K")) * -10*global.fpsMult)

with obj_editorCharacters
{x+=_hsp;y+=_vsp}
with obj_editorCharacters_ghost
{x+=_hsp;y+=_vsp}
with obj_stageobj
{x+=_hsp;y+=_vsp}

if keyboard_check_pressed(vk_f1)
	event_user(0)

if buttonslimit < array_length(things)
{
	if keyboard_check_pressed(vk_delete)
		instance_create_depth(0,0,0,obj_editorCharacters_delete)

	if keyboard_check_pressed(vk_left)
	|| keyboard_check_pressed(vk_down)
	|| keyboard_check_pressed(vk_up)
	|| keyboard_check_pressed(vk_right)
	{
		var f = sprw_frames[ds_list_find_value(sprw_cur_anim_frames, sprw_frame_index)]
		for (var i = 0; i < ds_list_size(sprw_offset_keys); i++)
		{
			var key = sprw_offset_keys[| i]
			if string_starts_with(f[0], key)
			{
				if keyboard_check_pressed(vk_left)
					sprw_offsets[? key][0] += (keyboard_check(vk_shift) ? 10 : 1)
				if keyboard_check_pressed(vk_down)
					sprw_offsets[? key][1] -= (keyboard_check(vk_shift) ? 10 : 1)
				if keyboard_check_pressed(vk_up)
					sprw_offsets[? key][1] += (keyboard_check(vk_shift) ? 10 : 1)
				if keyboard_check_pressed(vk_right)
					sprw_offsets[? key][0] -= (keyboard_check(vk_shift) ? 10 : 1)
				break
			}
		}
	}
}