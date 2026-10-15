if keyboard_check_pressed(vk_anykey) && !keyboard_check_pressed(vk_enter) && !keyboard_check_pressed(vk_f1)
{
	global.mGP_keys[i] = real(keyboard_lastkey)
	i++
	if dir == "Left" { dir = "Down" exit }
	if dir == "Down" { dir = "Up" exit }
	if dir == "Up" { dir = "Right" exit }
	if dir == "Right"
	{
		instance_destroy()
		mS_save()
		mS_load(false)
		exit
	}
}