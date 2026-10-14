if !sprw_exists(id)
{
	instance_destroy()
	exit
}
x = global.mGP_strumpos[noteDir][0]-97
y = global.mGP_strumpos[noteDir][1]-87
if sprw_frame_index >= ds_list_size(sprw_cur_anim_frames) - 1
{
	if !loop
		instance_destroy()
	else if hold && loop
	{
		loopCount++
		if noteDir == 0 || noteDir == 4
			anim = "holdCoverPurple"
		else if noteDir == 1 || noteDir == 5
			anim = "holdCoverBlue"
		else if noteDir == 2 || noteDir == 6
			anim = "holdCoverGreen"
		else if noteDir == 3 || noteDir == 7
			anim = "holdCoverRed"
		if loopCount == 2
		{
			loop = false
			if noteDir == 0 || noteDir == 4
				anim = "holdCoverEndPurple"
			else if noteDir == 1 || noteDir == 5
				anim = "holdCoverEndBlue"
			else if noteDir == 2 || noteDir == 6
				anim = "holdCoverEndGreen"
			else if noteDir == 3 || noteDir == 7
				anim = "holdCoverEndRed"
		}
		sprw_play(anim, true)
	}
}