x = mGP_strumX()
y = mGP_strumY()
if note_time - 50 <= global.mGP_curTime && dir <= 3
{
	if audio_exists(obj_mainGamePlay.vocals)
		audio_sound_gain(obj_mainGamePlay.vocals, 1, 0)
	if audio_exists(obj_mainGamePlay.vocals1)
		audio_sound_gain(obj_mainGamePlay.vocals1, 1, 0)
	mGP_hitNote(dir, true, abs(y - global.mGP_strumpos[dir][1]), endpart)
	if global.mGP_strumpress[dir] < 0.5
	{
		global.mGP_strumpress[dir] = 1
		with obj_characterDad
		{
			singtime = 0.9
			if other.dir == 0
				sprw_play("singLEFT", true)
			else if other.dir == 1
				sprw_play("singDOWN", true)
			else if other.dir == 2
				sprw_play("singUP", true)
			else if other.dir == 3
				sprw_play("singRIGHT", true)
		}
	}
    instance_destroy()
}
if dir >= 4 && y <= -100 + (global.mGP_strumpos[dir][1]-64)
{
	if !global.mS_botPlay
	{
		if audio_exists(obj_mainGamePlay.vocals)
			audio_sound_gain(obj_mainGamePlay.vocals, 0, 0)
		if audio_exists(obj_mainGamePlay.vocals2)
			audio_sound_gain(obj_mainGamePlay.vocals2, 0, 0)
		global.mGP_health -= (0.04/20)
		global.mGP_score -= 4
	    with obj_characterBF
	    {
	        singtime = 2
	        switch other.dir
	        {
	            case 4: sprw_play("singLEFTmiss", true) break
	            case 5: sprw_play("singDOWNmiss", true) break
	            case 6: sprw_play("singUPmiss", true) break
	            case 7: sprw_play("singRIGHTmiss", true) break
	        }
	    }
	}
	instance_destroy()
}