if gotooptions
	room_goto(rm_mainSettings)
if gotodebugmenu
	room_goto(rm_debugmenu)
if !started
{
	if keyboard_check_pressed(vk_enter)
	{
		alpha = 1
		started = true
		image_xscale = 0.8
		image_yscale = 0.8
		audio_stop_all()
		audio_play_sound(musicendID, 10, false)
		start_timer = 3
	}
	if !variable_instance_exists(id, "oldCurBeat")
	    oldCurBeat = 0
	curBeat = floor(audio_sound_get_track_position(music) / (60 / bpm))
	if curBeat != oldCurBeat
	{
		oldCurBeat = curBeat
	    image_xscale = 0.7
	    image_yscale = 0.7
	}
}
image_xscale = lerp(image_xscale, 0.65, (started ? 0.025 : 0.1) * global.fpsMult)
image_yscale = image_xscale
if started
{
	alpha -= (1/90) * global.fpsMult
	if start_timer < 0 && started <= 1
	{
		started = 2
		with instance_create_depth(0,0,0,obj_fadeout)
			roomTarget = rm_mainGamePlay
	}
	else
		start_timer -= global.fpsMult/60
}