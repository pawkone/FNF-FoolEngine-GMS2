if stop
	exit


if paused
{
	var _o = select
	select += keyboard_check_pressed(vk_down)-keyboard_check_pressed(vk_up)
	select += mouse_wheel_down()-mouse_wheel_up()
	if select > array_length(text)-1
		select = 0
	else if select < 0
		select = array_length(text)-1
	if _o != select
		audio_play_sound(global.sfx_mnu_scroll,1,false)
	y = lerp(y, select*150, 0.15*global.fpsMult)
	if keyboard_check_pressed(vk_enter) || mouse_check_button_pressed(mb_left)
	{
		if array_length(textcmd) > select && !script_exists(textcmd[select])
			script_execute(textcmd[select])
		else
			audio_play_sound(global.sfx_mnu_cancel,1,false)
	}
}

if (keyboard_check_pressed(vk_escape) || (keyboard_check_pressed(vk_enter) && !paused)) && pausebuffer <= 0
{
	paused = !paused
	pausebuffer = 3
	event_user(paused ? 0 : 1)
}

if pausebuffer > 0
	pausebuffer--


if paused || image_alpha != 0
{
	image_alpha = lerp(image_alpha, paused, 0.35*global.fpsMult)
	if image_alpha > 0.99 && paused
		image_alpha = 1
	else if image_alpha < 0.01 && !paused
		image_alpha = 0
}