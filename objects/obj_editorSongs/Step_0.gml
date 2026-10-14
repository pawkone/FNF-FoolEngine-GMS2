if !audio_is_playing(inst)
	get_song_audio()
if keyboard_check_pressed(vk_escape) && global.savedebugmenu_fromdebug
	room_goto(rm_debugmenu)
if keyboard_check_pressed(vk_control)
{
	if mult == 1
		mult = 2
	else if mult == 2
		mult = 4
	else if mult == 4
		mult = 1
}

if keyboard_check_pressed(vk_f1)
	event_user(0)
if keyboard_check_pressed(vk_f2)
	event_user(1)

if audio_exists(inst) && !audio_is_paused(inst)
	_current_time = audio_sound_get_track_position(inst)*1000
var _accel = (-0.03/mult)/(global.fpsMult)*1000
if keyboard_check(vk_shift)
	_accel = (-0.15/mult)/(global.fpsMult)*1000
if keyboard_check_pressed(vk_space)
	paused = !paused
	

if keyboard_check(vk_down)
	_current_time -= _accel
if keyboard_check(vk_up)
	_current_time += _accel
if _current_time < -1500
	_current_time = audio_sound_length(inst)*1000
if _current_time > audio_sound_length(inst)*1000
	_current_time = -1500


if paused || keyboard_check(vk_up) || keyboard_check(vk_down)
{
	if !audio_is_paused(inst)
	{
		audio_pause_sound(inst)
		if audio_exists(vocals)
			audio_pause_sound(vocals)
		if audio_exists(vocals1)
			audio_pause_sound(vocals1)
		if audio_exists(vocals2)
			audio_pause_sound(vocals2)
	}
}
else
{
	if audio_is_paused(inst)
	{
		audio_resume_sound(inst)
		if audio_exists(vocals)
			audio_resume_sound(vocals)
		if audio_exists(vocals1)
			audio_resume_sound(vocals1)
		if audio_exists(vocals2)
			audio_resume_sound(vocals2)
			
		audio_sound_set_track_position(inst, _current_time/1000)
		if audio_exists(vocals)
			audio_sound_set_track_position(vocals, _current_time/1000)
		if audio_exists(vocals1)
			audio_sound_set_track_position(vocals1, _current_time/1000)
		if audio_exists(vocals2)
			audio_sound_set_track_position(vocals2, _current_time/1000)
	}
}