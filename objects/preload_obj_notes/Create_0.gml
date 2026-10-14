if instance_number(object_index) >= 2
{
	instance_destroy()
	exit
}
sprw_load(global.mGP_sprite_ui, 24)
failed = !sprw_exists(id)
if failed
	exit

sprw_add("StrumlineConfirmLEFT", [30, 30])
sprw_add("StrumlineConfirmDOWN", [38, 40])
sprw_add("StrumlineConfirmUP", [40, 37])
sprw_add("StrumlineConfirmRIGHT", [33, 36])
sprw_add("StrumlinePressLEFT", [-5, -5])
sprw_add("StrumlinePressDOWN", [-3, -3])
sprw_add("StrumlinePressUP", [-2, -2])
sprw_add("StrumlinePressRIGHT", [-2, -2])

sprw_play("noteLEFT", true)
anim_preloadLeft = [sprw_cur_anim, sprw_cur_anim_frames, sprw_frame_index, sprw_frame_timer]
sprw_play("noteDOWN", true)
anim_preloadDown = [sprw_cur_anim, sprw_cur_anim_frames, sprw_frame_index, sprw_frame_timer]
sprw_play("noteUP", true)
anim_preloadUp = [sprw_cur_anim, sprw_cur_anim_frames, sprw_frame_index, sprw_frame_timer]
sprw_play("noteRIGHT", true)
anim_preloadRight = [sprw_cur_anim, sprw_cur_anim_frames, sprw_frame_index, sprw_frame_timer]

sprw_play("noteLEFThold", true)
anim_preloadLeftHold = [sprw_cur_anim, sprw_cur_anim_frames, sprw_frame_index, sprw_frame_timer]
sprw_play("noteDOWNhold", true)
anim_preloadDownHold = [sprw_cur_anim, sprw_cur_anim_frames, sprw_frame_index, sprw_frame_timer]
sprw_play("noteUPhold", true)
anim_preloadUpHold = [sprw_cur_anim, sprw_cur_anim_frames, sprw_frame_index, sprw_frame_timer]
sprw_play("noteRIGHThold", true)
anim_preloadRightHold = [sprw_cur_anim, sprw_cur_anim_frames, sprw_frame_index, sprw_frame_timer]

sprw_play("noteLEFTend", true)
anim_preloadLeftEnd = [sprw_cur_anim, sprw_cur_anim_frames, sprw_frame_index, sprw_frame_timer]
sprw_play("noteDOWNend", true)
anim_preloadDownEnd = [sprw_cur_anim, sprw_cur_anim_frames, sprw_frame_index, sprw_frame_timer]
sprw_play("noteUPend", true)
anim_preloadUpEnd = [sprw_cur_anim, sprw_cur_anim_frames, sprw_frame_index, sprw_frame_timer]
sprw_play("noteRIGHTend", true)
anim_preloadRightEnd = [sprw_cur_anim, sprw_cur_anim_frames, sprw_frame_index, sprw_frame_timer]