if instance_exists(obj_characterBF)
{
	xstart = obj_characterBF.x
	ystart = obj_characterBF.y
	x = xstart
	y = ystart
	with obj_characterBF
		instance_destroy()
}

audio_stop_all()
intro = true
comfirmed = false

deadsfxid = soundpool_load(global.assetsfolder + "sounds/fnf_loss_sfx.ogg")
deadsfx = audio_play_sound(deadsfxid,1,false)
deadmusicid = soundpool_load(global.assetsfolder + "music/gameOver.ogg")
deadmusic = -4
deadendmusicid = soundpool_load(global.assetsfolder + "music/gameOverEnd.ogg")
deadendmusic = -4

oldCurBeat = -4
jsonData_character("bf-dead")
sprw_play("deathStart",true)

timer = 0