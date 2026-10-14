mGP_init()

function mGP_error(_msg)
{
	with all
		instance_destroy(id, false)
	audio_stop_all()
	show_message(_msg)
}

global.mGP_name = "NO SONG"
global.mGP_chart = "chart" //but with suffixs like "-hard"

function mGP_init()
{
	get_settings()

	global.mGP_disablePause = false
	global.mGP_skipCountdown = false
	global.mGP_hideRating = false
	global.mGP_sprite_ui = assetsfolder + "images/ui/uiArrows"
	global.mGP_sprite_rating_sick = spritepool_load(assetsfolder + "images/ui/rating/sick.png")
	global.mGP_sprite_rating_good = spritepool_load(assetsfolder + "images/ui/rating/good.png")
	global.mGP_sprite_rating_bad = spritepool_load(assetsfolder + "images/ui/rating/bad.png")
	global.mGP_sprite_rating_shit = spritepool_load(assetsfolder + "images/ui/rating/shit.png")
	global.mGP_sprite_countdown_go = spritepool_load(assetsfolder + "images/ui/countdown/go.png", 1, -1, -1)
	global.mGP_sprite_countdown_set = spritepool_load(assetsfolder + "images/ui/countdown/set.png", 1, -1, -1)
	global.mGP_sprite_countdown_ready = spritepool_load(assetsfolder + "images/ui/countdown/ready.png", 1, -1, -1)
	
	global.mGP_cameraNote = true
	global.mGP_cameraNote_intensityBF = 24
	global.mGP_cameraNote_intensityDad = 24

	//dont change this
	//vvv
	global.mGP_speed = 3.1
	global.mGP_charBF = "bf"
	global.mGP_charDad = "dad"
	global.mGP_charGF = "gf"
	global.mGP_stage = "stage"
	global.mGP_zooming = true
	global.mGP_songended = false
	global.mGP_gameX = 0
	global.mGP_gameY = 0
	global.mGP_gameAngle = 0
	global.mGP_gameAlpha = 1
	global.mGP_gameZoomDef = 1
	global.mGP_gameZoom = global.mGP_gameZoomDef
	global.mGP_hudX = 0
	global.mGP_hudY = 0
	global.mGP_hudAngle = 0
	global.mGP_hudAlpha = 1
	global.mGP_hudZoom = 1
	global.mGP_shader = -4
	global.mGP_shaderScript = -4
	global.mGP_iconZoom = 1
	global.mGP_health = 1
	global.mGP_misses = 0
	global.mGP_score = 0
	global.mGP_hudSurface = -4 
	global.mGP_hudSurface_u8 = -4
	global.mGP_curTime = 0
	global.mGP_curBeat = 0
	global.mGP_beat = false
	global.mGP_bpm = 100
	global.mGP_camSpd = 1
	global.mGP_beatoffset = -4
	global.mGP_beatsoffset = -4
	global.mGP_strumpress = [0, 0, 0, 0  ,  0, 0, 0, 0]
	global.mGP_strumpos[0] = [32, 64]
	global.mGP_strumpos[1] = [152, 64]
	global.mGP_strumpos[2] = [272, 64]
	global.mGP_strumpos[3] = [392, 64]
	global.mGP_strumpos[4] = [640, 64]
	global.mGP_strumpos[5] = [760, 64]
	global.mGP_strumpos[6] = [880, 64]
	global.mGP_strumpos[7] = [1000, 64]
	for (var i = 0; i < array_length(global.mGP_strumpos); i++)
	{
		global.mGP_strumposOG[i][0] = global.mGP_strumpos[i][0]
		global.mGP_strumposOG[i][1] = global.mGP_strumpos[i][1]
	}
	//^^^
}
function mGP_endSong()
{
	audio_stop_all()
	var _room = rm_titleScreen
	with instance_create_depth(0,0,0,obj_fadeout)
		roomTarget = _room
}

function mGP_strumX()
{
	if variable_instance_exists(id, "strumid")
		return global.mGP_strumpos[strumid][0]
	return global.mGP_strumpos[dir][0]
}
function mGP_strumY()
{
	if variable_instance_exists(id, "strumid")
		return global.mGP_strumpos[strumid][1]
	return ((note_time - global.mGP_curTime)*(global.mGP_speed/2)) + global.mGP_strumpos[dir][1] - 35
}
function mGP_hitNote(dirNote, holdNote, distanceToPerfect = 0, endpart = false)
{
	if dirNote >= 4
	{
		global.mGP_health += !holdNote ? 0.023 : (0.023/20)
		if !holdNote
		{
			if distanceToPerfect <= 33
				global.mGP_score += 350
			else if  distanceToPerfect <= 92
				global.mGP_score += 200
			else if distanceToPerfect <= 133
				global.mGP_score += 100
			else
				global.mGP_score += 50
			if !global.mGP_hideRating
			{
				with instance_create_depth(0,0,-1000,obj_rating)
				{
					if distanceToPerfect <= 33
						sprite_index = global.mGP_sprite_rating_sick
					else if  distanceToPerfect <= 92
						sprite_index = global.mGP_sprite_rating_good
					else if distanceToPerfect <= 133
						sprite_index = global.mGP_sprite_rating_bad
					else
						sprite_index = global.mGP_sprite_rating_shit
				}
			}
		}
		else
			global.mGP_score += 2
	}
	if global.settings_noteSplashes
	{
		if !holdNote && dirNote >= 4
		{
			with instance_create_depth(0,0,0,obj_arrowSplashes)
			{
				sprw_frame_rate = irandom_range(22,26)
				noteDir = dirNote
				x = global.mGP_strumpos[noteDir][0]-97
				y = global.mGP_strumpos[noteDir][1]-87
				hold = false
				var _str = string(irandom_range(1, 2))
				anim = ""
				if !preload_obj_notes.failed
				{
					if noteDir == 4
						anim = "splash" + _str + "LEFT"
					else if noteDir == 5
						anim = "splash" + _str + "DOWN"
					else if noteDir == 6
						anim = "splash" + _str + "UP"
					else if noteDir == 7
						anim = "splash" + _str + "RIGHT"
					else
						instance_destroy()
					sprw_play(anim, true)
				}
			}
		}
		else if holdNote //also for daddy queerest hahahaha!
		{
			with instance_create_depth(0,0,0,obj_arrowSplashes)
			{
				noteDir = dirNote
				x = global.mGP_strumpos[noteDir][0]-97
				y = global.mGP_strumpos[noteDir][1]-87
				hold = true
				anim = ""
				if !preload_obj_notes.failed
				{
					if noteDir == 0 || noteDir == 4
						anim = "holdCover" + (endpart ? "End" : "Start") + "Purple"
					else if noteDir == 1 || noteDir == 5
						anim = "holdCover" + (endpart ? "End" : "Start") + "Blue"
					else if noteDir == 2 || noteDir == 6
						anim = "holdCover" + (endpart ? "End" : "Start") + "Green"
					else if noteDir == 3 || noteDir == 7
						anim = "holdCover" + (endpart ? "End" : "Start") + "Red"
					else
						instance_destroy()
					sprw_play(anim, true)
				}
				if !endpart
				{
					loop = true
					var _del = false
					with obj_arrowSplashes
					{
						if id != other.id && loop && hold && noteDir == dirNote
						{
							loopCount = 0
							_del = true
						}
					}
					if _del
						instance_destroy()
				}
				else
				{
					with obj_arrowSplashes
					{
						if id != other.id && loop && hold && noteDir == dirNote
							instance_destroy()
					}
				}
			}
		}
	}
}