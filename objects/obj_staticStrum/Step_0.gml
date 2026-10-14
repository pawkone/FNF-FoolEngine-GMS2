x = mGP_strumX()
y = mGP_strumY()
if global.mGP_strumpress[strumid] == 1
	sprw_play("StrumlineConfirm" + string_upper(dir), true)
else if global.mGP_strumpress[strumid] <= 0
{
	if dirnum != -4
	{
		if keyboard_check_pressed(global.mGP_keys[dirnum])
			sprw_play("StrumlinePress" + string_upper(dir), true)
		else if !keyboard_check(global.mGP_keys[dirnum])
			sprw_play("StrumlineStatic" + string_upper(dir), true)
	}
	else
		sprw_play("StrumlineStatic" + string_upper(dir), true)
}
global.mGP_strumpress[strumid] -= 0.1 * global.fpsMult