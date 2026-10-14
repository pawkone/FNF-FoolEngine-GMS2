if keyboard_check_pressed(vk_shift)
	toggle = !toggle

if !toggle
{
	var _oldselect = select
	if keyboard_check_pressed(vk_left) select--
	else if keyboard_check_pressed(vk_right) select++
	select = clamp(select, 0, array_length(items)-1)
	
	var _la = keyboard_check_pressed(vk_enter)
	|| keyboard_check_pressed(vk_space)
	|| keyboard_check_pressed(vk_escape)
	
	if _la || _oldselect != select
	{
		global.mS_hitsoundName = items[select]
		mS_hitsound()
		event_user(0)
		if _la
			alarm[0] = 2
	}
}
else if keyboard_check_pressed(vk_escape)
	alarm[0] = 2