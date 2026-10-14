if roomLagDelay-- <= 0
	global.fpsMult = delta_time * 0.00006
if fp_updatetime <= 0
{
	fp_updatetime = 30
	fp = "FPS: " + string(fps)
	fp += "\nglobal.fpsMult: " + string(global.fpsMult)
}
else
	fp_updatetime -= global.fpsMult
if keyboard_check_pressed(187)
{
	volume += 1/6
	volume = clamp(volume, 0, 1)
	audio_master_gain(volume)
	audio_play_sound(sfx_beep,1,false)
}
else if keyboard_check_pressed(189)
{
	volume -= 1/6
	volume = clamp(volume, 0, 1)
	audio_master_gain(volume)
	audio_play_sound(sfx_beep,1,false)
}