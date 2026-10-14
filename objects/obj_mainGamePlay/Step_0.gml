//endsong system
if timer > 0
{
	var _oldtimer = timer
	timer -= global.fpsMult/60
	
	audio_pause_sound(inst)
	audio_pause_sound(vocals)
	audio_pause_sound(vocals1)
	audio_pause_sound(vocals2)
	
	global.mGP_beat = false
	
	var _o = time_bpm_to_seconds(global.mGP_bpm), _asts = [[global.mGP_sprite_countdown_go, countdown_gosfx], [global.mGP_sprite_countdown_ready, countdown_1sfx], [global.mGP_sprite_countdown_set, countdown_2sfx], [-4, countdown_3sfx]]
	for (var i = 1; i <= 4; i++)
	{
		if _oldtimer >= _o*i && timer < _o*i
		{
			if i < 4
			{
				countdownspr = _asts[i-1][0]
				countdownalpha = 1
				countdowntime = 1
			}
			oldCurBeat = -i
			global.mGP_curBeat = oldCurBeat
			global.mGP_beat = true
			audio_play_sound(_asts[i-1][1],1,false,0.5,0,1)
			break
		}
	}

	countdownalpha = gmltween_EaseOutCubic(countdowntime,0,1,1)
	countdowntime -= (delta_time/1000000)/_o
	global.mGP_curTime = (timer*-1000)
	if timer <= 0
	{
		timer = 0
		audio_resume_sound(inst)
		audio_resume_sound(vocals)
		audio_resume_sound(vocals1)
		audio_resume_sound(vocals2)
		var __scrpath = assetsfolder + "songs/" + global.mGP_name + "/scr_songstart.gml"
		gmlscr_read(__scrpath)
	}
}
else
{
	if !audio_is_playing(inst) && !global.mGP_songended
	{
		/*
		// LOOP SONG CODE HERE
		get_song_audio()
		instance_destroy(obj_arrow)
		instance_destroy(obj_arrowHold)
		triggered = []
		for (var i = 0; i < array_length(notes); i++)
			triggered[i] = false
		*/
		var __scrpath = assetsfolder + "songs/" + global.mGP_name + "/scr_songend.gml"
		gmlscr_read(__scrpath)
		global.mGP_songended = true
		mGP_endSong()
	}
	if !audio_is_playing(inst)
		exit
	global.mGP_curTime = audio_sound_get_track_position(inst)*1000
	
	//bpm system
	for (var i = 0; i < array_length(bpmchanges); i++)
	{
		var bpmcha = bpmchanges[i]
		if !bpmchangestri[i] && global.mGP_curTime >= bpmcha[0]
		{
			bpmchangestri[i] = true
			global.mGP_beatoffset = bpmcha[0]/1000
			global.mGP_beatsoffset = floor((global.mGP_curTime/1000) / (60 / global.mGP_bpm))
			global.mGP_bpm = bpmcha[1]
		}
	}
	if global.mGP_beatoffset != -4
		global.mGP_curBeat = global.mGP_beatsoffset + floor(((global.mGP_curTime/1000)-global.mGP_beatoffset) / (60 / global.mGP_bpm))
	else
		global.mGP_curBeat = floor((global.mGP_curTime/1000) / (60 / global.mGP_bpm))
	if global.mGP_curBeat != oldCurBeat
	{
		oldCurBeat = global.mGP_curBeat
		global.mGP_beat = true
	}
	else
		global.mGP_beat = false
}

if snipscr_update != -4
	live_snippet_call(snipscr_update)

//bopppp canmeraa and icons
if global.mGP_beat
{
	global.mGP_iconZoom += 0.125
	if global.mGP_curBeat mod 4 == 0
	{
		global.mGP_gameZoom += 0.015
		global.mGP_hudZoom += 0.03
	}
}
global.mGP_iconZoom = lerp(global.mGP_iconZoom, 1, 0.2 * global.fpsMult)

/*
#region test modchart
var _mult = 1
for (var i = 0; i < 8; i++)
{
	var _x = sin((global.mGP_curTime + i*243+global.mGP_curBeat*232)/132)*16*_mult
	
	var _y = (32 + -abs(sin(((global.mGP_curTime/1000) / (60 / global.mGP_bpm))*pi))*64)*_mult
	_y += cos((global.mGP_curTime +i*243+global.mGP_curBeat*232)/132)*16*_mult
	
	global.mGP_strumpos[i][0] = lerp(global.mGP_strumpos[i][0], global.mGP_strumposOG[i][0] + _x, 0.3*global.fpsMult)
	global.mGP_strumpos[i][1] = lerp(global.mGP_strumpos[i][1], global.mGP_strumposOG[i][1] + _y, 0.3*global.fpsMult)
}
#endregion
*/


// INPUT ENGINE - only press the closest note PER INPUT
// cuz old was pressing multiple per input and i hate it AGGHH

//HOLD NOTES
with (obj_arrowHold)
{
    var key = noone
	if dir >= 4 && dir <= 7
		key = global.mGP_keys[dir-4]
	var dist = abs(global.mGP_curTime - note_time)
	if dist <= 35
	{
	    if (global.settings_botPlay || keyboard_check(key))
		{
			if audio_exists(obj_mainGamePlay.vocals)
				audio_sound_gain(obj_mainGamePlay.vocals, 1, 0)
			if audio_exists(obj_mainGamePlay.vocals2)
				audio_sound_gain(obj_mainGamePlay.vocals2, 1, 0)
			mGP_hitNote(dir, true, dist, endpart)
			if global.mGP_strumpress[dir] < 0.5
			{
			    with (obj_characterBF)
			    {
			        singtime = 0.9
			        switch (other.dir)
			        {
	                    case 4: sprw_play("singLEFT", true) break
	                    case 5: sprw_play("singDOWN", true) break
	                    case 6: sprw_play("singUP", true) break
	                    case 7: sprw_play("singRIGHT", true) break
			        }
			    }
			    global.mGP_strumpress[dir] = 1
			}
		    instance_destroy()
		}
	}
}

//SIGNLE NOTES
for (var d = 4; d <= 7; d++)
{
    var key = noone
	if d >= 4 && d <= 7
		key = global.mGP_keys[d-4]
    if keyboard_check_pressed(key) || global.settings_botPlay
    {
        var nearest_note = noone
        var nearest_dist = 999999
        with (obj_arrow)
        {
			if dir == d
			{
				var dist = abs(global.mGP_curTime - note_time)
	            if dist <= 100 && dist < nearest_dist
	            {
	                nearest_note = id
	                nearest_dist = dist
	            }
			}
        }
        if nearest_note != noone // DIDN'T MISS
        {
			if audio_exists(vocals)
				audio_sound_gain(vocals, 1, 0)
			if audio_exists(vocals2)
				audio_sound_gain(vocals2, 1, 0)
			if global.settings_hitSounds
				audio_play_sound(global.sfx_hitsound, 1, false)
			with nearest_note
            {
				mGP_hitNote(d, false, abs(global.mGP_curTime - note_time))
                with obj_characterBF
                {
                    singtime = 0.9
                    switch d
                    {
                        case 4: sprw_play("singLEFT", true) break
                        case 5: sprw_play("singDOWN", true) break
                        case 6: sprw_play("singUP", true) break
                        case 7: sprw_play("singRIGHT", true) break
                    }
                }
                global.mGP_strumpress[d] = 1
                instance_destroy()
            }
        }
		else if !global.settings_ghostTapping && !global.settings_botPlay // MISSED (if no ghost tapping)
		{
			if audio_exists(vocals)
				audio_sound_gain(vocals, 0, 0)
			if audio_exists(vocals2)
				audio_sound_gain(vocals2, 0, 0)
			global.mGP_health -= 0.06
			global.mGP_score -= 10
			global.mGP_misses++
			audio_play_sound(choose(misssounds[0], misssounds[1], misssounds[2]), 1, false, 0.35)
            with obj_characterBF
            {
                singtime = 2
                switch d
                {
                    case 4: sprw_play("singLEFTmiss", true) break
                    case 5: sprw_play("singDOWNmiss", true) break
                    case 6: sprw_play("singUPmiss", true) break
                    case 7: sprw_play("singRIGHTmiss", true) break
                }
            }
		}
    }
}










//time tarvel woah
if keyboard_check(vk_f2)
{
	instance_destroy(obj_arrow)
	instance_destroy(obj_arrowHold)
	triggered = []
	for (var i = 0; i < array_length(notes); i++)
		triggered[i] = false
	
	if audio_exists(inst)
		audio_sound_set_track_position(inst, (global.mGP_curTime/1000)-0.25)
	if audio_exists(vocals)
		audio_sound_set_track_position(vocals, (global.mGP_curTime/1000)-0.25)
	if audio_exists(vocals1)
		audio_sound_set_track_position(vocals1, (global.mGP_curTime/1000)-0.25)
	if audio_exists(vocals2)
		audio_sound_set_track_position(vocals2, (global.mGP_curTime/1000)-0.25)
}
else if keyboard_check(vk_f3)
{
	if audio_exists(inst)
		audio_sound_set_track_position(inst, (global.mGP_curTime/1000)+0.25)
	if audio_exists(vocals)
		audio_sound_set_track_position(vocals, (global.mGP_curTime/1000)+0.25)
	if audio_exists(vocals1)
		audio_sound_set_track_position(vocals1, (global.mGP_curTime/1000)+0.25)
	if audio_exists(vocals2)
		audio_sound_set_track_position(vocals2, (global.mGP_curTime/1000)+0.25)
}

//NOTE SPAWNING SYSTEM
for (var i = 0; i < array_length(notes); i++)
{
	var note = notes[i]
	if !triggered[i] && global.mGP_curTime >= note[0] - (2500 / global.mGP_speed) - global.gameSizeH
	{
		triggered[i] = true
		with(instance_create_depth(0, 0, -1000, obj_arrow))
		{
			note_time = note[0]
			dir = note[1]
			x = mGP_strumX()
			y = mGP_strumY()
			if !preload_obj_notes.failed
			{
				sprw_animnames = preload_obj_notes.sprw_animnames
			    sprw_offsets = preload_obj_notes.sprw_offsets
			    sprw_offset_keys = preload_obj_notes.sprw_offset_keys
			    sprw_anims = preload_obj_notes.sprw_anims
			    sprw_anim_keys = preload_obj_notes.sprw_anim_keys
			    sprw_frames = preload_obj_notes.sprw_frames
			    sprw_frame_rate = preload_obj_notes.sprw_frame_rate
			    sprw_frame_index = preload_obj_notes.sprw_frame_index
			    sprw_frame_timer = preload_obj_notes.sprw_frame_timer
			    sprw_cur_anim = preload_obj_notes.sprw_cur_anim
			    sprw_cur_anim_frames = preload_obj_notes.sprw_cur_anim_frames
				sprw_sprite = preload_obj_notes.sprw_sprite
				sprw_loop = preload_obj_notes.sprw_loop
				sprite_index = sprw_sprite
				var _anim = preload_obj_notes.anim_preloadLeft
				if (dir == 1 || dir == 5) _anim = preload_obj_notes.anim_preloadDown
				if (dir == 2 || dir == 6) _anim = preload_obj_notes.anim_preloadUp
				if (dir == 3 || dir == 7) _anim = preload_obj_notes.anim_preloadRight
				sprw_cur_anim = _anim[0]
				sprw_cur_anim_frames = _anim[1]
				sprw_frame_index = _anim[2]
				sprw_frame_timer = _anim[3]
			}
			if note[2] == 0
				break
			var _holdt = (global.mGP_bpm/100)
			for (var i = 60; round(note[2]/_holdt) > i; i += 10)
			{
				with(instance_create_depth(0, 0, -999, obj_arrowHold))
				{
					note_time = note[0] + i
					dir = note[1]
					x = mGP_strumX()
					y = mGP_strumY()
					endpart = round(note[2]/_holdt) < i + 11
					if !preload_obj_notes.failed
					{
						sprw_animnames = preload_obj_notes.sprw_animnames
					    sprw_offsets = preload_obj_notes.sprw_offsets
					    sprw_offset_keys = preload_obj_notes.sprw_offset_keys
					    sprw_anims = preload_obj_notes.sprw_anims
					    sprw_anim_keys = preload_obj_notes.sprw_anim_keys
					    sprw_frames = preload_obj_notes.sprw_frames
					    sprw_frame_rate = preload_obj_notes.sprw_frame_rate
					    sprw_frame_index = preload_obj_notes.sprw_frame_index
					    sprw_frame_timer = preload_obj_notes.sprw_frame_timer
					    sprw_cur_anim = preload_obj_notes.sprw_cur_anim
					    sprw_cur_anim_frames = preload_obj_notes.sprw_cur_anim_frames
						sprw_sprite = preload_obj_notes.sprw_sprite
						sprw_loop = preload_obj_notes.sprw_loop
						sprite_index = sprw_sprite
			
						if endpart
						{
							var _anim = preload_obj_notes.anim_preloadLeftEnd
							if (dir == 1 || dir == 5) _anim = preload_obj_notes.anim_preloadDownEnd
							if (dir == 2 || dir == 6) _anim = preload_obj_notes.anim_preloadUpEnd
							if (dir == 3 || dir == 7) _anim = preload_obj_notes.anim_preloadRightEnd
						}
						else
						{
							var _anim = preload_obj_notes.anim_preloadLeftHold
							if (dir == 1 || dir == 5) _anim = preload_obj_notes.anim_preloadDownHold
							if (dir == 2 || dir == 6) _anim = preload_obj_notes.anim_preloadUpHold
							if (dir == 3 || dir == 7) _anim = preload_obj_notes.anim_preloadRightHold
						}
						sprw_cur_anim = _anim[0]
						sprw_cur_anim_frames = _anim[1]
						sprw_frame_index = _anim[2]
						sprw_frame_timer = _anim[3]
					}
				}
			}
		}
	}
}







//cam system
for (var i = 0; i < array_length(camchanges); i++)
{
	var camcha = camchanges[i]
	if !camchangestri[i] && global.mGP_curTime >= camcha[0]
	{
		camchangestri[i] = true
		mustHitcam = camcha[1]
	}
}

//making camera acutltyasyaqyu do shit
var _camid = view_camera[0], _camspd = global.mGP_camSpd == 0 ? 1 : (0.1 * global.fpsMult * global.mGP_camSpd), _camofx = 0, _camofy = -75, _mGP_gameX = 0, _mGP_gameY = 0
if mustHitcam
{
	if instance_exists(obj_characterBF)
	{
		if global.mGP_cameraNote
		{
			with obj_characterBF
			{
				if sprw_is_anim_playing("singLEFT")
					_mGP_gameX -= global.mGP_cameraNote_intensityBF
				if sprw_is_anim_playing("singDOWN")
					_mGP_gameY += global.mGP_cameraNote_intensityBF
				if sprw_is_anim_playing("singUP")
					_mGP_gameY -= global.mGP_cameraNote_intensityBF
				if sprw_is_anim_playing("singRIGHT")
					_mGP_gameX += global.mGP_cameraNote_intensityBF
			}
		}
		global.mGP_gameX = lerp(global.mGP_gameX,obj_characterBF.x+obj_characterBF.camOffset[0]-_camofx+_mGP_gameX,_camspd)
		global.mGP_gameY = lerp(global.mGP_gameY,obj_characterBF.y+obj_characterBF.camOffset[1]-_camofy+_mGP_gameY,_camspd)
	}
}
else
{
	if instance_exists(obj_characterDad)
	{
		if global.mGP_cameraNote
		{
			with obj_characterDad
			{
				if sprw_is_anim_playing("singLEFT")
					_mGP_gameX -= global.mGP_cameraNote_intensityDad
				if sprw_is_anim_playing("singDOWN")
					_mGP_gameY += global.mGP_cameraNote_intensityDad
				if sprw_is_anim_playing("singUP")
					_mGP_gameY -= global.mGP_cameraNote_intensityDad
				if sprw_is_anim_playing("singRIGHT")
					_mGP_gameX += global.mGP_cameraNote_intensityDad
			}
		}
		global.mGP_gameX = lerp(global.mGP_gameX,obj_characterDad.x+obj_characterDad.camOffset[0]-_camofx+_mGP_gameX,_camspd)
		global.mGP_gameY = lerp(global.mGP_gameY,obj_characterDad.y+obj_characterDad.camOffset[1]-_camofy+_mGP_gameY,_camspd)
	}
}
if global.mGP_zooming
{
	global.mGP_hudZoom = lerp(global.mGP_hudZoom, 1, 0.05 * global.fpsMult)
	global.mGP_gameZoom = lerp(global.mGP_gameZoom, global.mGP_gameZoomDef, 0.05 * global.fpsMult)

}
global.mGP_hudX = -(global.mGP_hudZoom-1) * global.gameSizeW/2
global.mGP_hudY = -(global.mGP_hudZoom-1) * global.gameSizeH/2
var _camzm = clamp(2-global.mGP_gameZoom,0.01,10)
var _camw = global.gameSizeW*_camzm
var _camh = global.gameSizeH*_camzm
camera_set_view_size(_camid, _camw, _camh)
camera_set_view_pos(_camid, global.mGP_gameX-_camw/2, global.mGP_gameY-_camh/2)
camera_set_view_angle(_camid, global.mGP_gameAngle)